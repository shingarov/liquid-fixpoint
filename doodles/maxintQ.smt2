(qualif PApp1 ((VV (@(0))) (p ((P @(0))))) (papp1 p VV))
(qualif PApp2 ((VV (@(1))) (x0 (@(0))) (p ((P @(0) @(1))))) (papp2 p x0 VV))
(qualif PApp3 ((VV (@(2))) (x0 (@(0))) (x1 (@(1))) (p ((P @(0) @(1) @(2))))) (papp3 p x0 x1 VV))
 
(var $k3 ((int)))
(var $k2 ((int)))
(var $k1 ((int) ((P int)) (int) (int)))
 
(constant papp3 (func(3 , [(P @(0) @(1) @(2));
                           @(0);
                           @(1);
                           @(2);
                           bool])))
(constant papp2 (func(2 , [(P @(0) @(1)); @(0); @(1); bool])))
(constant papp1 (func(1 , [(P @(0)); @(0); bool])))
 
(constraint
 (and
  (forall ((p (P int)) (true))
   (forall ((x int)   (papp1 p x))
    (forall ((y int)   (papp1 p y))
     (and
      (forall ((v int) (and (papp1 p v) (v == x))) (($k1 v p x y)))
      (forall ((v int) (and (papp1 p v) (v == y))) (($k1 v p x y)))
      (forall ((b bool) (b <=> x < y))
       (and
        (forall ((g4 bool) (b))
         (forall ((v int) (and (papp1 p v) (v == y))) ((papp1 p v))))
        (forall ((g5 bool) (not b))
         (forall ((v int) (and (papp1 p v) (v == x))) ((papp1 p v))))))))))
  (and
   (forall ((a int)  (0 < a))
    (forall ((b int)  (0 < b))
     (and
       (forall ((v int) (and (0 < v) (v == a))) (($k2 v)))
       (forall ((v int) (and (0 < v) (v == b))) (($k2 v)))
       (forall ((v int) ($k2 v)) ((0 < v))))))
    (forall ((a int)  (a < 0))
     (forall ((b int)  (b < 0))
      (and
        (forall ((v int) (and (v < 0) (v == a))) (($k3 v)))
        (forall ((v int) (and (v < 0) (v == b))) (($k3 v)))
        (forall ((v int) ($k3 v)) ((v < 0)))))))))
