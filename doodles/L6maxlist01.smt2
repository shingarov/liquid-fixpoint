(qualif Geq ((v (int)) (n (int))) (n <= v))
(qualif AbsPred ((v (int)) (f (func(0 , [int; bool])))) (f v))
(qualif PApp1 ((VV (@(0))) (p ((Pred @(0))))) (papp1 p VV))
 
(var $k14 ((int)))
(var $k13 ((int)))
(var $k12 ((int) ((Pred int)) ((list int))))
(var $k10 ((int) ((Pred int)) ((list int)) ((list int)) (int)))
(var $k8 ((int) ((Pred int)) ((list int)) ((list int)) (int)))
(var $k6 ((int)))
(var $k5 ((int) ((Pred int)) (int) (int)))
(var $k3 ((b) ((list a)) ((list a)) (b) (a)))
(var $k1 ((a) ((list a)) ((list a)) (b) (a)))
 
(constant papp1 (func(1 , [(Pred @(0)); @(0); bool])))
 
(constraint
 (and
  (forall ((b b) (true))
   (forall ((xs (list a)) (true))
    (and
     (forall ((h a)  (true))
      (forall ((t (list a))  (true))
       (forall ((xs (list a))  (true))
        (and
         (and
          (and
           (and
            (forall ((_ a)  ($k1 _ xs t b h) )
             (and
              (forall ((_ b)  ($k3 _ xs t b h) )
               (forall ((VV b)  (true))
                 (($k3 VV xs t b h)))))))
           (forall ((VV b)  (VV == b))
             (($k3 VV xs t b h))))
           (forall ((VV a)  (true))
             (($k1 VV xs t b h)))))))))))
  (and
   (forall ((p (Pred int)) (true))
    (forall ((x int)  (papp1 p x))
     (forall ((y int)  (papp1 p y))
      (and
       (and
        (forall ((v int) (and  (papp1 p v) (v == x)))
          (($k5 v p x y)))
        (forall ((v int) (and  (papp1 p v) (v == y)))
          (($k5 v p x y))))
       (forall ((b bool) (and (b <=> x < y)))
        (and
         (forall ((grd5 bool) (b))
          (forall ((v int) (and  (papp1 p v) (v == y)))
           (((papp1 p v)))))
         (forall ((grd5 bool) (not b))
          (forall ((v int) (and  (papp1 p v) (v == x)))
           (((papp1 p v)))))))))))
   (and
    (forall ((quxx (Pred int)) (true))
     (forall ((xs (list int))  (true))
      (and
       (forall ((h int) (papp1 quxx h))
        (forall ((t (list int))  (true))
         (forall ((xs (list int))  (true))
          (and
           (and
            (and
             (and
              (forall ((VV7 int) ($k8 VV7 quxx xs t h))
               (($k6 VV7)))
              (forall ((_ int) ($k8 _ quxx xs t h))
               (and
                (forall ((VV9 int) ($k10 VV9 quxx xs t h))
                 (($k6 VV9)))
                (forall ((_ int) ($k10 _ quxx xs t h))
                 (forall ((v int) ($k6 v))
                   (($k10 v quxx xs t h)))))))
             (forall ((v int) (and  (papp1 quxx v)  (v == h)))
               (($k10 v quxx xs t h))))
            (and
             (forall ((v int)  (papp1 quxx v))
               (($k8 v quxx xs t h)))))
           (forall ((VV9 int) ($k10 VV9 quxx xs t h))
            (((papp1 quxx VV9))))))))
       (forall ((xs (list int))  (true))
        (and
         (forall ((VV11 int)  ($k12 VV11 quxx xs))
          (((papp1 quxx VV11)))))))))
    (and
     (forall ((xs (list int))  (true))
      (and
       (and
        (forall ((v int) (0 <= v))
         (($k13 v))))
       (forall ((v int)  ($k13 v))
        (((0 <= v))))))
      (forall ((xs (list int)) (true))
       (and
        (forall ((v int) (and (v <= 0)))
          (($k14 v)))
        (forall ((v int)  ($k14 v))
         (((v <= 0)))))))))))
