 
(data L 1 = [
        | Nil {}
        | Cons {Cons0 : @(0), Cons1 : (L @(0))}
      ])
 
(constant len (func(1 , [(L @(0)); int])))

(constraint
     (forall ((h a) (true))
      (forall ((t (L a)) (true))
       (forall ((zs (L a)) (and (len zs > 0)  (len zs == 1 + len t)))
         (forall ((VV (L a)) (VV == t)) (((len VV == len zs - 1))))))))
