-- | Progress Bar API
module Language.Fixpoint.Utils.Progress (
      withProgress
    , progressTick
    , progressClose
    ) where

import           Control.Monad                    (when)
import           System.IO.Unsafe                 (unsafePerformIO)
import           Data.IORef
import           System.Console.AsciiProgress
-- import           Language.Fixpoint.Misc (traceShow)

{-# NOINLINE pbRef #-}
pbRef :: IORef (Maybe ProgressBar)
pbRef = unsafePerformIO (newIORef Nothing)

withProgress :: Int -> IO a -> IO a
withProgress _ act = do
  act
  
progressTick :: IO ()
progressTick    = go =<< readIORef pbRef
  where
   go (Just pr) = incTick pr
   go _         = return ()

incTick :: ProgressBar -> IO () 
incTick pb = do
  st <- getProgressStats pb 
  when (incomplete st) (tick pb)
    -- then tick pb -- putStrLn (show (stPercent st, stTotal st, stCompleted st)) >> (tick pb)
    -- else return () 

incomplete :: Stats -> Bool 
incomplete st = {- traceShow "INCOMPLETE" -} (stRemaining st) > 0 
-- incomplete st = stPercent st < 100


progressClose :: IO ()
progressClose = go =<< readIORef pbRef
  where
    go (Just p) = complete p
    go _        = return ()
