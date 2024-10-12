(var $k1 ((int) (int) ((Coord int int)) (int) (int)))
 
(data Coord 2 = [
        | C {C##0 : @(0), C##1 : @(1)}
      ])
 
(constraint
  (and
    (forall ((n int) (true))
      (forall ((n1 int) (and (n1 == n + 1)))
         (forall ((v int) (and (v == n + 1) (v == n1))) ((n < v)))))
    (forall ((m int) (true))
      (forall ((p (Coord int int)) (true))
        (forall ((px int)  (true))
          (forall ((py int) (px < py))
           (forall ((p (Coord int int)) (true))
            (and
              (forall ((VV int)  (VV == px)) (($k1 VV m p px py)))
              (forall ((v int) (and (px < v) (v == py))) (($k1 v m p px py)))
              (forall ((ok bool) (ok <=> px < py))
                (forall ((v bool) (and (v <=> px < py) (v == ok))) ((v))))))))))))
