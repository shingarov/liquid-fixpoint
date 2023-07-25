(var $k ((int) (int) (int)))
 
(constraint
 (and
  (and
   (forall ((x int) (true))
    (forall ((VV int) (VV == 10))
     (((VV >= 0)))))
   (and
    (forall ((z int) (true))
     (and
      (and
       (forall ((r int) ($k r z z))
        (forall ((VV0 int) (and ($k VV0 z z) (VV0 == r)))
         (((VV0 >= 0))))))
      (and
       (and
        (forall ((y int) (true))
         (forall ((v1 int) (v1 >= 0))
          (($k v1 z y))))))))))))
