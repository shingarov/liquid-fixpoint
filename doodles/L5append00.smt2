(var $k3 ((a) ((list a)) ((list a)) ((list a)) (a) ((list a))))
(var $k1 ((a) ((list a)) ((list a)) ((list a)) (a)))
 
(constant len (func(1 , [(list @(0)); int])))
 
(constraint
  (forall ((xs (list a))  (true))
   (forall ((ys (list a))  (true))
    (and
     (forall ((xs (list a))  (len xs == 0))
       (forall ((VV (list a))  (VV == ys))
        ((len VV == len xs + len ys))))
     (forall ((h a) (true))
      (forall ((t (list a))  (true))
       (forall ((xs (list a))  (len xs == 1 + len t))
        (and
         (forall ((VV a)  (true)) (($k1 VV xs t ys h)))
         (forall ((VV a)  (true)) (($k1 VV t t ys h)))
         (forall ((rest (list a))  (len rest == len t + len ys))
          (and
            (forall ((VV a)  (VV == h)) (($k3 VV xs t ys h rest)))
            (forall ((VV##0 a)  ($k1 VV##0 t t ys h))  (($k3 VV##0 xs t ys h rest)))
            (forall ((v (list a)) (and (len v == 1 + len rest))) (((len v == len xs + len ys))))))))))))))
