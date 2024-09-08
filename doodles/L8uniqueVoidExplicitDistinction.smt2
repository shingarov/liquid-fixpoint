(var $k1 ((V) (V) (V) (int) (V)))
 
(data V 0 = [
        | One {}
        | Two {}
      ])
 
(constraint
    (forall ((a V) (a == One))
      (forall ((b V) (b == One))
          ((a == b)))))
