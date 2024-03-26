(fixpoint "--rewrite") 

(constant sum (func(0 , [int; int])))
 
(define sum (m : int) : int = {((if (m <= 0) then 0 else (m + (sum (m - 1)))))})
 
(constraint
  (forall ((n int) (0 <= n))
     (forall ((base bool)  (base <=> (n <= 0)))
      (and
       (forall ((lq_tmp bool) (base))
         ((2 * sum n == n * (n + 1))))
       (forall ((lq_tmp bool) (not base))
         (forall ((n1 int)  (n1 == n - 1))
          (and
           (forall ((v int) (and (v == n - 1) (v == n1)))
            (and
             ((0 <= v))
             ((v < n))
             ((0 <= v))))
           (forall ((v int)  (2 * sum n1 == n1 * (n1 + 1)))
            (((2 * sum n == n * (n + 1))))))))))))
