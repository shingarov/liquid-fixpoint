(constant len (func(1 , [(l @(0)); int])))

(constraint
  (forall ((x a) (true))
   (forall ((t (l a)) ((len t) == 0))
     (forall ((v (l a)) ((v == t)))
      ((((len v) == 0)))))))

