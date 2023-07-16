(var $k ((Int) ((l Int)) ((l Int)) ((l Int)) (Int) ((l Int))))
 
(constant len (func(1 , [(l @(0)); int])))
 
(constraint
  (forall ((xs (l Int)) (true))
   (forall ((ys (l Int)) (true))
    (and
     (forall ((xs (l Int)) (len xs == 0))
       (forall ((VV (l Int)) (VV == ys))
         (((len VV == len xs + len ys)))))
     (forall ((h Int) (true))
      (forall ((t (l Int)) (true))
       (forall ((xs (l Int))  (len xs == 1 + len t))
         (forall ((rest (l Int)) (len rest == len t + len ys))
          (and
            (forall ((VV Int) (VV == h))
              (($k VV xs t ys h rest)))
            (forall ((VV Int) (true))
              (($k VV xs t ys h rest)))
            (forall ((v (l Int)) (len v == 1 + len rest))
              (((len v == len xs + len ys)))))))))))))
