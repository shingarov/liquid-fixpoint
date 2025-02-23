(fixpoint "--rewrite")

(var $k_1 ((a) (a) (a)))
 
(constant cheq (func(1, [@(0); @(0); bool])))

(define cheq (x : a,  y : a) : bool = { x == y })
 
(constraint
 (and
  (forall ((x a) (true))
   (forall ((y a) (true))
    (and
      (forall ((VV a) (VV == x))
        (($k_1 VV x y)))
      (forall ((VV a) (VV == y))
        (($k_1 VV x y))))))
  (and
   (forall ((x int)  (true))
    (forall ((VV int) (VV == 0))
     ((cheq 2 2))))
   (forall ((x int)  (true))
     (forall ((VV int) (VV == 0))
      (((cheq true true))))))))
