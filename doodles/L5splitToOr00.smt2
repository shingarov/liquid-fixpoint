(var $k5 ((int) (i) (bool) (i) (i) (int)))
(var $k3 ((int) (i) (i) (i) (int)))
(var $k1 ((int) (i) (i)))
 
(constant encoding (func(0 , [i; int])))
 
(constraint
  (and
   (forall ((insn i) (true))
    (and
     (forall ((insn i) (and (true) (encoding insn == 0)))
      (forall ((VV int) (VV == 0))
       (($k1 VV A B))))
     (forall ((insn i) (and (true) (encoding insn == 1)))
      (forall ((VV int) (VV == 1))
       (($k1 VV A B))))))
   (forall ((insn i) (true))
     (forall ((e int) ($k1 e A B))
       (and
        (and
         (forall ((VV##0 int) (and ($k1 VV##0 A B) (VV##0 == e)))
          (($k3 VV##0 insn A B e)))
         (forall ((VV int) (VV == 0))
          (($k3 VV insn A B e))))
        (forall ((isZero bool) (isZero <=> e == 0))
         (and
          (and
           (forall ((VV##0 int) (and ($k1 VV##0 A B) (VV##0 == e)))
            (($k5 VV##0 insn isZero A B e)))
           (forall ((VV int) (VV == 1))
            (($k5 VV insn isZero A B e))))
          (forall ((isOne bool) (isOne <=> e == 1))
            (forall ((good bool) (good <=> isZero || isOne))
              (forall ((v bool) (and (v <=> isZero || isOne) (v == good)))
               ((v))))))))))))
