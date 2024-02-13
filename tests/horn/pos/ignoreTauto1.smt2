(fixpoint "--eliminate=horn")

(constraint 
  (forall ((x Int) (x > 10))
    (forall ((y Int) (y > A))
      (and))))
