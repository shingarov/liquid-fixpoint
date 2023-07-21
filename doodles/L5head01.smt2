(var $k9 ((int) ((list int)) (int)))
(var $k7 ((int) (int)))
(var $k5 ((a) ((list a)) (a)))
(var $k3 ((a) (a)))
(var $k1 ((a) ((list a))))
 
(constant len (func(1 , [(list @(0)); int])))
 
(constraint
 (and
  (forall ((xs (list a)) (len xs > 0))
    (forall ((xs (list a)) (and (len xs > 0) (len xs == 0)))
      (forall ((VV int) (VV == 0)) ((false)))))
  (and
   (forall ((x a) (true))
    (forall ((t (list a)) (len t == 0))
     (and
       (forall ((VV a) (VV == x)) (($k5 VV t x)))
       (forall ((VV2 a) (and ($k3 VV2 x) (true))) (($k5 VV2 t x)))
       (forall ((v (list a)) (len v == 1 + len t)) (((len v == 1)))))))
   (forall ((z int) (true))
     (and
      (forall ((VV int) (VV == z)) (($k7 VV z)))
      (forall ((l (list int)) (len l == 1))
       (and
         (forall ((w (list int)) (and (len w == 1) (w == l))) (((len w > 0))))
         (forall ((VV6 int) (and ($k7 VV6 z) (true))) (($k9 VV6 l z))))))))))
