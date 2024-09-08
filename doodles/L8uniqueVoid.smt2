(data V 0 = [
        | Nil {}
      ])
 
(constraint
    (forall ((a V) (true))
      (forall ((b V) (true))
          ((a == b)))))
