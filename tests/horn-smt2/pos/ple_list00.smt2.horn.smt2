(fixpoint  --rewrite)
 
 
 
(constant len ((func 1 (((MyList  @(0)))) int)))
(constant Cons ((func 2 ((@(0))  ((MyList  @(0)))) (MyList  @(0)))))
(constant Nil ((MyList  @(0))))
 
 
 
(constraint
   (and
      (forall ((x (int)) (true))
         (forall ((y (int)) ((==  y  2)))
            (forall ((z (int)) ((==  z  3)))
               ((==  (len  ((Cons  x)  ((Cons  y)  ((Cons  z)  Nil))))  3)))))))