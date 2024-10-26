(var $k3 ((bob) ((list alice)) ((list alice)) (bob) (alice)))
(var $k1 ((alice) ((list alice)) ((list alice)) (bob) (alice)))
 
(constraint
  (forall ((b bob) (true))
   (forall ((xs (list alice)) (true))
     (forall ((h alice) (true))
      (forall ((t (list alice)) (true))
       (forall ((xs (list alice)) (true))
        (and
           (forall ((_ alice) (and ($k1 _ xs t b h) (true)))
              (forall ((_ bob) (and ($k3 _ xs t b h) (true)))
               (forall ((VV bob) (true)) (($k3 VV xs t b h)))))
           (forall ((VV bob) ((VV == b))) (($k3 VV xs t b h)))
           (forall ((VV alice) (true)) (($k1 VV xs t b h))))))))))
