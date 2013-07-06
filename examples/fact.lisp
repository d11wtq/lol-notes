;;; fact.lisp --- Factorial implementation using nlet.

(defun fact (n)
  (nlet fact ((n n) (acc 1))
    (if (zerop n)
        acc
      (fact (1- n) (* n acc)))))
