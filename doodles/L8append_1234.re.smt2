(fixpoint "--rewrite")
(var $k3 ((a) ((L a)) ((L a)) ((L a)) (a) ((L a))))
(var $k1 ((a) ((L a)) ((L a)) ((L a)) (a)))
 
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
    (forall ((v (L a))  (v == Nil && len v == 0))
      (((len v >= 0))))
    (forall ((x a)  (true))
     (forall ((xs (L a))  (len xs >= 0))
       (forall ((v (L a)) (v == Cons x xs && len v == 1 + len xs))
        (((len v >= 0))))))))
  (and
   (forall ((xs (L a))  (len xs >= 0))
    (forall ((ys (L a))  (len ys >= 0))
     (and
      (forall ((h a)  (true))
       (forall ((t (L a))  (len t >= 0))
        (forall ((xs (L a)) (and (xs == Cons h t && len xs == 1 + len t) (len xs >= 0)))
         (and
          (and
           (and
            (forall ((VV (L a)) (and (VV == t) (len VV >= 0)))
              (((0 <= len VV && len VV < len xs))))
            (forall ((VV a)  (true))
              (($k1 VV xs t ys h))))
            (forall ((VV a) (true))
              (($k1 VV xs t ys h))))
          (forall ((rest (L a))  (len rest >= 0))
           (and
             (forall ((VV a) (VV == h))
               (($k3 VV xs t ys h rest)))
             (forall ((VV##0 a) ($k1 VV##0 xs t ys h))
                (($k3 VV##0 xs t ys h rest))))))))))))
    (forall ((x int)  (true))
     (forall ((VV int) (VV == 0))
      (((app (Cons 1 (Cons 2 Nil)) (Cons 3 (Cons 4 Nil)) == Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))))))))))
