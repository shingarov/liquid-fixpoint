(qualif Geq ((v (int)) (n (int))) (n <= v))
(qualif AbsPred ((v (int)) (f (func(0 , [int; bool])))) (f v))
(qualif PApp1 ((VV (@(0))) (p ((Pred @(0))))) (papp1 p VV))
 
(var $k_14 ((int)))
(var $k_13 ((int)))
(var $k_12 ((int) ((Pred int)) ((list int))))
(var $k_10 ((int) ((Pred int)) ((list int)) ((list int)) (int)))
(var $k_8 ((int) ((Pred int)) ((list int)) ((list int)) (int)))
(var $k_6 ((int)))
(var $k_5 ((int) ((Pred int)) (int) (int)))
(var $k_3 ((b) ((list a)) ((list a)) (b) (a)))
(var $k_1 ((a) ((list a)) ((list a)) (b) (a)))
 
(constant papp1 (func(1 , [(Pred @(0)); @(0); bool])))
 
(constraint
 (and
  (forall ((b b) (true))
   (forall ((xs (list a))  (true))
    (and
     (forall ((h a) (true))
      (forall ((t (list a))  (true))
       (forall ((xs (list a))  (true))
        (and
         (and
          (and
           (and
            (forall ((_ a) (and ($k_1 _ xs t b h) (true)))
             (and
              (forall ((_ b) (and ($k_3 _ xs t b h)  (true)))
               (forall ((VV b)  (true))
                 (($k_3 VV xs t b h)))))))
           (forall ((VV b)  (VV == b))
             (($k_3 VV xs t b h))))
           (forall ((VV a) (true))
             (($k_1 VV xs t b h))
             )))))))))
  (and
   (forall ((p (Pred int)) (true))
    (forall ((x int)  (papp1 p x))
     (forall ((y int)  (papp1 p y))
      (and
       (and
        (forall ((v int) (and  (papp1 p v) (v == x)))
          (($k_5 v p x y)))
        (forall ((v int) (and  (papp1 p v) (v == y)))
          (($k_5 v p x y))))
       ))))
   (and
    (forall ((quxx (Pred int)) (true))
     (forall ((xs (list int)) (true))
      (and
       (forall ((h int)  (papp1 quxx h))
        (forall ((t (list int))  (true))
         (forall ((xs (list int)) (true))
          (and
           (and
            (and
             (and
              (forall ((VV7 int) ($k_8 VV7 quxx xs t h))
               (($k_6 VV7)))
              (forall ((_ int) ($k_8 _ quxx xs t h))
               (and
                (forall ((VV9 int) ($k_10 VV9 quxx xs t h))
                 (($k_6 VV9)))
                (forall ((_ int) ($k_10 _ quxx xs t h))
                 (forall ((VV int)  (true))
                   (($k_10 VV quxx xs t h)))))))
             (forall ((v int) (and (papp1 quxx v) (v == h)))
               (($k_10 v quxx xs t h))))
            (and
             (forall ((v int)  (papp1 quxx v))
               (($k_8 v quxx xs t h)))))
           (forall ((VV9 int) ($k_10 VV9 quxx xs t h))
            ((papp1 quxx VV9)))))))
       (forall ((xs (list int)) (true))
        (and
         (forall ((VV11 int) ($k_12 VV11 quxx xs))
          ((papp1 quxx VV11))))))))
    (and
     (forall ((xs (list int)) (true))
      (and
       (and
        (forall ((v int) (0 <= v))
         (($k_13 v))))
       (forall ((v int)  ($k_13 v))
        ((0 <= v)))))
     (and
      (forall ((xs (list int)) (true))
       (and
        (and
         (forall ((v int) (v <= 0))
          (($k_14 v))))
        (forall ((v int)  ($k_14 v))
         ((v <= 0)))))
      ))))))
