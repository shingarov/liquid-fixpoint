(fixpoint "--rewrite")

(var $k_6 ((a) ((L a)) ((L a)) ((L a)) (a) ((L a))))
(var $k_3 ((a) ((L a)) ((L a)) ((L a)) (a) ((L a))))
(var $k_1 ((a) ((L a)) ((L a)) ((L a)) (a)))
 
(constant app (func(1 , [(L @(0)); (L @(0)); (L @(0))])))
(constant len (func(1 , [(L @(0)); int])))
 
(define app (xs : (L a),  ys : (L a)) : (L a) = {(if (is$Nil xs) then ys else (Cons (Cons__0 xs) (app (Cons__1 xs) ys)))})
 
(data L 1 = [
        | Nil {}
        | Cons {Cons__0 : @(0), Cons__1 : (L @(0))}
      ])
 
(constraint
 (and
  (and
   (and
    (and
     (forall ((v (L a)) (and (v == Nil && len v == 0)))
      (((len v >= 0)))))
    (forall ((x a)  (true))
     (forall ((xs (L a)) (len xs >= 0))
       (forall ((v (L a)) (and (v == Cons x xs && len v == 1 + len xs)))
        (((len v >= 0))))))))
  (and
   (forall ((xs (L a))  (len xs >= 0))
    (forall ((ys (L a))  (len ys >= 0))
     (and
      (forall ((h a) (true))
       (forall ((t (L a))  (len t >= 0))
        (forall ((xs (L a))   (xs == Cons h t && len xs == 1 + len t && len xs >= 0))
         (and
          (and
           (and
            (forall ((VV (L a))   (VV == t && len VV >= 0))
              (((0 <= len VV && len VV < len xs))))
            (forall ((VV a)  (true))
              (($k_1 VV xs t ys h))))
            (forall ((VV a)  (true))
              (($k_1 VV xs t ys h))))
          (forall ((rest (L a))  (len rest >= 0))
           (and
            (and
             (forall ((VV a)  (VV == h))
               (($k_3 VV xs t ys h rest)))
             (forall ((VV0 a) ($k_1 VV0 xs t ys h))
                (($k_3 VV0 xs t ys h rest)))))))))))))
   (and
    (forall ((xs (L a))  (len xs >= 0))
     (forall ((ys (L a))  (len ys >= 0))
      (forall ((zs (L a))  (len zs >= 0))
       (and
        (forall ((xs (L a))  (xs == Nil && len xs == 0))
         (forall ((VV int) (VV == 0))
          (((app (app xs ys) zs == app xs (app ys zs))))))
        (forall ((x a)  (true))
         (forall ((xs' (L a))  (len xs' >= 0))
          (forall ((xs (L a))  (xs == Cons x xs' && len xs == 1 + len xs' && len xs >= 0))
           (and
            (and
             (and
              (and
               (forall ((VV (L a)) (VV == xs' && len VV >= 0))
                 (((0 <= len VV && len VV < len xs))))
               (forall ((VV a)  (true))
                 (($k_6 VV xs xs' ys x zs))))
              (and
               (forall ((VV a)  (true))
                 (($k_6 VV xs xs' ys x zs)))))
              (forall ((VV a) (true))
                (($k_6 VV xs xs' ys x zs))))
            (forall ((v int) (and (app (app xs' ys) zs == app xs' (app ys zs))))
             (((app (app xs ys) zs == app xs (app ys zs)))))))))))))))))
