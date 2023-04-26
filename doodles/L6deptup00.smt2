(var $k9 ((int) (int)))
(var $k8 ((int) (int) (int)))
(var $k6 ((int) (int) (int)))
(var $k4 ((int) (int)))
(var $k3 ((int) (int) (int)))
(var $k1 ((int) (int) (int)))
 
(constraint
 (and
  (forall ((x int) (true))
    (forall ((y int)  (x + 1 == y))
     (and
      (and
       (forall ((VV int)  (VV == x))
         (($k1 VV x y)))
       (forall ((v int) (and  (x + 1 == v) (v == y)))
        (and
         (($k3 v x y))
         (($k4 x v)))))
        (forall ((rvTmp0 int) (true))
         (forall ((rvTmp1 int)  ($k4 rvTmp0 rvTmp1))
          (((rvTmp0 < rvTmp1))))))))
   (forall ((x int)  (true))
     (forall ((y int)  (x + 1 == y))
      (and
       (and
        (forall ((v int) (and (x + 1 == v) (v == y)))
          (($k6 v x y)))
        (forall ((VV int)  (VV == x))
         (and (($k8 VV y y)) (($k9 y VV)))))
         (forall ((rvTmp0 int) (true))
          (forall ((rvTmp1 int)  ($k9 rvTmp0 rvTmp1))
           (((rvTmp0 > rvTmp1))))))))))
