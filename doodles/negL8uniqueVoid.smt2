(data V 0 = [
        | One {}
        | Two {}
      ])
 
(constraint
    (forall ((a V) (true))
      (forall ((b V) (true))
          ((a == b)))))
