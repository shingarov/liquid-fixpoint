(qualif Pos ((v (int))) (0 <= v))
(qualif Geq ((v (int)) (n (int))) (n <= v))
 
(var $k_##7 ((int) (int) (int)))
(var $k_##5 ((int) (int) (int)))
(var $k_##3 ((int) (int)))
(var $k_##1 ((int) (int)))
 
(constraint
 (and
  (and
   (forall ((n int) (and (true)))
    (and
     (and
      (forall ((VV int) (and (and (true)) (VV == n)))
        (($k_##3 VV n)))
      (forall ((VV int) (VV == 0))
        (($k_##3 VV n))))
     (forall ((cond bool) (and (cond <=> n <= 0)))
      (and
       (forall ((lq_tmp$grd##4 bool) (cond))
        (forall ((VV int) (VV == 0))
         (($k_##1 VV n))))
       (forall ((lq_tmp$grd##4 bool) (not cond))
         (forall ((n1 int) (and (n1 == n - 1)))
           (forall ((t1 int) ($k_##1 t1 n1))
             (forall ((v int) (and (v == n + t1)))
              (($k_##1 v n))))))))))
   (and
    (forall ((y int) (and (true)))
     (and
      (forall ((res int) ($k_##1 res y))
       (and
        (and
         (forall ((VV int) (VV == 0))
          (and
           (($k_##5 VV res y))
           ((true))))
         (forall ((VV##0 int) (and ($k_##1 VV##0 y) (VV##0 == res)))
          (and
           (($k_##5 VV##0 res y))
           ((true)))))
        (forall ((ok bool) (and (ok <=> 0 <= res)))
          (forall ((v bool) (and (and (v <=> 0 <= res)) (v == ok)))
           ((v))))))))
     (forall ((y int) (and (true)))
       (forall ((res int) ($k_##1 res y))
        (and
         (and
          (forall ((VV int) (and (and (true)) (VV == y)))
            (($k_##7 VV res y)))
          (forall ((VV##0 int) (and ($k_##1 VV##0 y) (VV##0 == res)))
            (($k_##7 VV##0 res y))))
         (forall ((ok bool) (and (ok <=> y <= res)))
           (forall ((v bool) (and (and (v <=> y <= res)) (v == ok)))
            ((v)))))))))))
