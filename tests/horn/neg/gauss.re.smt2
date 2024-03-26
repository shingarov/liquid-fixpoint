(fixpoint "--rewrite") 

(constant sum (func 0 (Int) Int))
 
(define sum ((n Int)) Int (if (<= n 0) 10 (+ n (sum (- n 1)))))
 
(constraint
  (forall ((n Int) ((<= 0 n)))
     (forall ((base bool)  ((<=> base (<= n 0))))
      (and
       (forall ((lq_tmp bool) (base))
         ((= ((* 2 ((sum n)))) ((* n ((+ n 1)))))))
       (forall ((lq_tmp bool) ((not base)))
         (forall ((n1 Int)  ((= n1 ((- n 1)))))
          (and
           (forall ((v Int) (and  ((= v ((- n 1))))  ((= v n1))))
            (and
             ((<= 0 v))
             ((<  v n))
             ((<= 0 v))))
           (forall ((v Int)  ((=   ((* 2 ((sum n1))))   ((* n1 ((+ n1 1)))))))
            ((= ((* 2 ((sum n)))) ((* n ((+ n 1))))))))))))))
