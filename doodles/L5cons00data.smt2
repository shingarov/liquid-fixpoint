(var $k3 ((a) ((L a)) (a)))
(var $k1 ((a) (a)))
 
(constant len (func(1 , [(L @(0)); int])))
 
(data L 1 = [
        | Nil {}
        | Cons {Cons##0 : @(0), Cons##1 : (L @(0))}
      ])
 
(constraint
   (forall ((x a) ((true)))
    (forall ((t (L a)) ((len t == 0)))
     (and
       (forall ((VV a) ((VV == x))) (($k3 VV t x)))
       (forall ((VV##0 a) ($k1 VV##0 x)) (($k3 VV##0 t x)))
       (forall ((v (L a)) ((len v == 1 + len t))) (((len v == 1))))))))
