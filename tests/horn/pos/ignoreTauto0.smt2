(fixpoint "--eliminate=horn")

(constraint 
  (forall ((x Int) (x > 10))
    (forall ((y Int) (y > 5))
      (and ((x>0))))))
