(var $k3 ((a) ((list a)) ((list a)) ((list a)) (a) ((list a))))
(var $k1 ((a) ((list a)) ((list a)) ((list a)) (a)))
 
(constant elts (func(1 , [(list @(0)); (Set_Set @(0))])))
 
(constraint
 (and
  (forall ((xs (list a)) (true))
   (forall ((ys (list a)) (true))
    (and
     (forall ((xs (list a)) (elts xs == Set_empty 0))
       (forall ((VV (list a)) (VV == ys))
        (((elts VV == Set_cup (elts xs) (elts ys))))))
     (forall ((h a) (true))
      (forall ((t (list a)) (true))
       (forall ((xs (list a)) (elts xs == Set_add (elts t) h))
        (and
         (forall ((VV a) (true)) (($k1 VV xs t ys h)))
         (forall ((VV a) (true)) (($k1 VV t t ys h)))
         (forall ((rest (list a)) (elts rest == Set_cup (elts t) (elts ys)))
          (and
            (forall ((VV a) (VV == h)) (($k3 VV xs t ys h rest)))
            (forall ((VV0 a) ($k1 VV0 t t ys h)) (($k3 VV0 xs t ys h rest)))
            (forall ((v (list a)) (elts v == Set_add (elts rest) h))
             (((elts v == Set_cup (elts xs) (elts ys))))))))))))))))
