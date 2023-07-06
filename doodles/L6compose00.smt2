(qualif PApp2 ((VV (@(1))) (x0 (@(0))) (p ((Pred @(0) @(1))))) (papp2 p x0 VV))
 
(constant papp2 (func(2 , [(Pred @(0) @(1)); @(0); @(1); bool])))
 
(constraint
  (forall ((p (Pred b c)) (true))
   (forall ((q (Pred a b)) (true))
    (forall ((r (Pred a c)) (true))
     (forall ((x a) (true))
       (forall ((t1 b) (papp2 q x t1))
         (forall ((t2 c) (papp2 p t1 t2))
          (and
           (and
            (forall ((v b) (and (papp2 q x v) (v == t1)))
             (((papp2 q x v))))
            (forall ((v c) (and (papp2 p t1 v) (v == t2)))
             (((papp2 p t1 v)))))
           (forall ((t3 Bool) (papp2 r x t2))
            (forall ((v c) (and (papp2 p t1 v) (v == t2)))
             (((papp2 r x v)))))))))))))
