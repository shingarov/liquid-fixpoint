{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

-- | This is a wrapper around IO that permits SMT queries

module Language.Fixpoint.Solver.Monad
       ( -- * Type
         SolveM

         -- * Execution
       , runSolverM

         -- * Get Binds
       , getBinds

         -- * SMT Query
       , filterRequired
       , filterValid
       , filterValidGradual
       , checkSat
       , smtEnablembqi

         -- * Debug
       , Stats
       , tickIter
       , stats
       , numIter
       )
       where

import           Control.DeepSeq
import           GHC.Generics
import           Language.Fixpoint.Utils.Progress
import qualified Language.Fixpoint.Types.Config  as C
import           Language.Fixpoint.Types.Config  (Config)
import qualified Language.Fixpoint.Types   as F
import qualified Language.Fixpoint.Misc    as Misc
import           Language.Fixpoint.SortCheck
import qualified Language.Fixpoint.Types.Solutions as F
import           Language.Fixpoint.Types   (pprint)
-- import qualified Language.Fixpoint.Types.Errors  as E
import           Language.Fixpoint.Smt.Serialize ()
import           Language.Fixpoint.Types.PrettyPrint ()
import           Language.Fixpoint.Smt.Interface
import qualified Language.Fixpoint.Smt.Theories as Thy
import           Language.Fixpoint.Solver.Sanitize
import           Language.Fixpoint.Graph.Types (SolverInfo (..))
-- import           Language.Fixpoint.Solver.Solution
-- import           Data.Maybe           (catMaybes)
import           Data.List            (partition)
-- import           Data.Char            (isUpper)
import           Text.PrettyPrint.HughesPJ (text)
import           Control.Monad.State.Strict
import qualified Data.HashMap.Strict as M
import           Data.Maybe (catMaybes)
import           Control.Exception.Base (bracket)

--------------------------------------------------------------------------------
-- | Solver Monadic API --------------------------------------------------------
--------------------------------------------------------------------------------

type SolveM = StateT SolverState IO

data SolverState = SS { ssCtx     :: !Context          -- ^ SMT Solver Context
                      , ssBinds   :: !F.SolEnv         -- ^ All variables and types
                      , ssStats   :: !Stats            -- ^ Solver Statistics
                      }

data Stats = Stats { numCstr :: !Int -- ^ # Horn Constraints
                   , numIter :: !Int -- ^ # Refine Iterations
                   , numBrkt :: !Int -- ^ # smtBracket    calls (push/pop)
                   , numChck :: !Int -- ^ # smtCheckUnsat calls
                   , numVald :: !Int -- ^ # times SMT said RHS Valid
                   } deriving (Show, Generic)

instance NFData Stats

stats0    :: F.GInfo c b -> Stats
stats0 fi = Stats nCs 0 0 0 0
  where
    nCs   = M.size $ F.cm fi


instance F.PTable Stats where
  ptable s = F.DocTable [ (text "# Constraints"         , pprint (numCstr s))
                        , (text "# Refine Iterations"   , pprint (numIter s))
                        , (text "# SMT Brackets"        , pprint (numBrkt s))
                        , (text "# SMT Queries (Valid)" , pprint (numVald s))
                        , (text "# SMT Queries (Total)" , pprint (numChck s))
                        ]

--------------------------------------------------------------------------------
runSolverM :: Config -> SolverInfo b c -> SolveM a -> IO a
--------------------------------------------------------------------------------
runSolverM cfg sI act =
  bracket acquire release $ \ctx -> do
    res <- runStateT act' (s0 ctx)
    smtWrite ctx "(exit)"
    return (fst res)
  where
    s0 ctx   = SS ctx be (stats0 fi)
    act'     = declare initEnv ds lts >> assumesAxioms (F.asserts fi) >> act
    release  = cleanupContext
    acquire  = makeContextWithSEnv cfg file initEnv
    initEnv  = symbolEnv   cfg fi
    lts      = F.toListSEnv (F.dLits fi)
    ds       = F.ddecls fi
    be       = F.SolEnv (F.bs fi)
    file     = C.srcFile cfg
    -- only linear arithmentic when: linear flag is on or solver /= Z3
    -- lar     = linear cfg || Z3 /= solver cfg
    fi       = (siQuery sI) {F.hoInfo = F.HOI (C.allowHO cfg) (C.allowHOqs cfg)}



--------------------------------------------------------------------------------
declare :: F.SymEnv -> [F.DataDecl] -> [(F.Symbol, F.Sort)] -> SolveM ()
--------------------------------------------------------------------------------
declare env ds lts = withContext $ \me -> do
  forM_ ds     $           smtDataDecl me
  forM_ thyXTs $ uncurry $ smtDecl     me
  forM_ qryXTs $ uncurry $ smtDecl     me
  forM_ ats    $ uncurry $ smtDecl     me
  forM_ ess    $           smtDistinct me
  forM_ axs    $           smtAssert   me
  where
    ess        = distinctLiterals  lts
    axs        = Thy.axiomLiterals lts
    thyXTs     =                    filter (isKind 1) xts
    qryXTs     = Misc.mapSnd tx <$> filter (isKind 2) xts
    isKind n   = (n ==)  . symKind env . fst
    xts        = F.toListSEnv           (F.seSort env)
    tx         = elaborate    "declare" env
    ats        = applyVars env

applyVars :: F.SymEnv -> [(F.Symbol, F.Sort)]
applyVars env = [(F.applyAtName env t, applySort t) | t@(F.FFunc {}) <- ts]
  where
    ts        = M.keys (F.seAppls env)

applySort :: F.Sort -> F.Sort
applySort (F.FFunc t1 t2) = F.mkFFunc 0 [F.intSort, fo t1, fo t2]
  where
    fo (F.FFunc {})       = F.intSort
    fo s                  = s
applySort t               = t

-- | 'symKind' returns {0, 1, 2} where:
--   0 = Theory-Definition,
--   1 = Theory-Declaration,
--   2 = Query-Binder

symKind :: F.SymEnv -> F.Symbol -> Int
symKind env x = case F.tsInterp <$> F.symEnvTheory x env of
                  Just F.Theory   -> 0
                  Just F.Data     -> 0
                  Just F.Uninterp -> 1
                  Nothing         -> 2
              -- Just t  -> if tsInterp t then 0 else 1


-- assumes :: [F.Expr] -> SolveM ()
-- assumes es = withContext $ \me -> forM_  es $ smtAssert me

-- | `distinctLiterals` is used solely to determine the set of literals
--   (of each sort) that are *disequal* to each other, e.g. EQ, LT, GT,
--   or string literals "cat", "dog", "mouse". These should only include
--   non-function sorted values.
distinctLiterals :: [(F.Symbol, F.Sort)] -> [[F.Expr]]
distinctLiterals xts = [ es | (_, es) <- tess ]
   where
    tess             = Misc.groupList [(t, F.expr x) | (x, t) <- xts, notFun t]
    notFun           = not . F.isFunctionSortedReft . (`F.RR` F.trueReft)
    -- _notStr          = not . (F.strSort ==) . F.sr_sort . (`F.RR` F.trueReft)


--------------------------------------------------------------------------------
getBinds :: SolveM F.SolEnv
--------------------------------------------------------------------------------
getBinds = ssBinds <$> get

--------------------------------------------------------------------------------
getIter :: SolveM Int
--------------------------------------------------------------------------------
getIter = numIter . ssStats <$> get

--------------------------------------------------------------------------------
incIter, incBrkt :: SolveM ()
--------------------------------------------------------------------------------
incIter   = modifyStats $ \s -> s {numIter = 1 + numIter s}
incBrkt   = modifyStats $ \s -> s {numBrkt = 1 + numBrkt s}

--------------------------------------------------------------------------------
incChck, incVald :: Int -> SolveM ()
--------------------------------------------------------------------------------
incChck n = modifyStats $ \s -> s {numChck = n + numChck s}
incVald n = modifyStats $ \s -> s {numVald = n + numVald s}

withContext :: (Context -> IO a) -> SolveM a
withContext k = (lift . k) =<< getContext

getContext :: SolveM Context
getContext = ssCtx <$> get

modifyStats :: (Stats -> Stats) -> SolveM ()
modifyStats f = modify $ \s -> s { ssStats = f (ssStats s) }

--------------------------------------------------------------------------------
-- | SMT Interface -------------------------------------------------------------
--------------------------------------------------------------------------------
-- | `filterRequired [(x1, p1),...,(xn, pn)] q` returns a minimal list [xi] s.t.
--   /\ [pi] => q
--------------------------------------------------------------------------------
filterRequired :: F.Cand a -> F.Expr -> SolveM [a]
--------------------------------------------------------------------------------
filterRequired = error "TBD:filterRequired"

{-
(set-option :produce-unsat-cores true)
(declare-fun x () Int)
(declare-fun y () Int)
(declare-fun z () Int)

; Z3 will only track assertions that are named.

(assert (< 0 x))
(assert (! (< 0 y)       :named b2))
(assert (! (< x 10)      :named b3))
(assert (! (< y 10)      :named b4))
(assert (! (< (+ x y) 0) :named bR))
(check-sat)
(get-unsat-core)

> unsat (b2 bR)
-}

--------------------------------------------------------------------------------
-- | `filterValid p [(x1, q1),...,(xn, qn)]` returns the list `[ xi | p => qi]`
--------------------------------------------------------------------------------
filterValid :: F.Expr -> F.Cand a -> SolveM [a]
--------------------------------------------------------------------------------
filterValid p qs = do
  qs' <- withContext $ \me ->
           smtBracket me "filterValidLHS" $
             filterValid_ p qs me
  -- stats
  incBrkt
  incChck (length qs)
  incVald (length qs')
  return qs'

filterValid_ :: F.Expr -> F.Cand a -> Context -> IO [a]
filterValid_ p qs me = catMaybes <$> do
  smtAssert me p
  forM qs $ \(q, x) ->
    smtBracket me "filterValidRHS" $ do
      smtAssert me (F.PNot q)
      valid <- smtCheckUnsat me
      return $ if valid then Just x else Nothing



--------------------------------------------------------------------------------
-- | `filterValidGradual ps [(x1, q1),...,(xn, qn)]` returns the list `[ xi | p => qi]`
-- | for some p in the list ps
--------------------------------------------------------------------------------
filterValidGradual :: [F.Expr] -> F.Cand a -> SolveM [a]
--------------------------------------------------------------------------------
filterValidGradual p qs = do
  qs' <- withContext $ \me ->
           smtBracket me "filterValidGradualLHS" $
             filterValidGradual_ p qs me
  -- stats
  incBrkt
  incChck (length qs)
  incVald (length qs')
  return qs'

filterValidGradual_ :: [F.Expr] -> F.Cand a -> Context -> IO [a]
filterValidGradual_ ps qs me
  = (map snd . fst) <$> foldM partitionCandidates ([], qs) ps
  where
    partitionCandidates :: (F.Cand a, F.Cand a) -> F.Expr -> IO (F.Cand a, F.Cand a)
    partitionCandidates (ok, candidates) p = do
      (valids', invalids')  <- partition snd <$> filterValidOne_ p candidates me
      let (valids, invalids) = (fst <$> valids', fst <$> invalids')
      return (ok ++ valids, invalids)

filterValidOne_ :: F.Expr -> F.Cand a -> Context -> IO [((F.Expr, a), Bool)]
filterValidOne_ p qs me = do
  smtAssert me p
  forM qs $ \(q, x) ->
    smtBracket me "filterValidRHS" $ do
      smtAssert me (F.PNot q)
      valid <- smtCheckUnsat me
      return $ ((q, x), valid)

smtEnablembqi :: SolveM ()
smtEnablembqi
  = withContext $ \me ->
      smtWrite me "(set-option :smt.mbqi true)"

--------------------------------------------------------------------------------
checkSat :: F.Expr -> SolveM  Bool
--------------------------------------------------------------------------------
checkSat p
  = withContext $ \me ->
      smtBracket me "checkSat" $
        smtCheckSat me p

--------------------------------------------------------------------------------
assumesAxioms :: [F.Triggered F.Expr] -> SolveM ()
--------------------------------------------------------------------------------
assumesAxioms es = withContext $ \me -> forM_  es $ smtAssertAxiom me


---------------------------------------------------------------------------
stats :: SolveM Stats
---------------------------------------------------------------------------
stats = ssStats <$> get

---------------------------------------------------------------------------
tickIter :: Bool -> SolveM Int
---------------------------------------------------------------------------
tickIter newScc = progIter newScc >> incIter >> getIter

progIter :: Bool -> SolveM ()
progIter newScc = lift $ when newScc progressTick
