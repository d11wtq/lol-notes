;;; util.lisp --- Common functions from Let Over Lambda

(defun mkstr (&rest args)
  "Create a string by by appending one or more strings"
  (with-output-to-string (s)
    (dolist (a args)
      (princ a s))))

(defun symb (&rest args)
  "Create a symbol from one or more strings"
  (values (intern (apply #'mkstr args))))

(defun group (source n)
  "Group a list into smaller lists of size N"
  (labels ((rec (source acc)
             (let ((tail (nthcdr n source)))
               (if (consp tail)
                   (rec tail (cons (subseq source 0 n) acc))
                 (nreverse (cons source acc))))))
    (if source
        (rec source nil)
      nil)))

(defun flatten (x)
  "Flatten a list of arbitrary depth into one dimension"
  (labels ((rec (x acc)
             (cond ((null x) acc)
                   ((atom x) (cons x acc))
                   (t (rec (car x)
                           (rec (cdr x) acc))))))
    (rec x nil)))

(defun fact (n)
  "Compute the factorial of integer N"
  (if (= n 0)
      1
    (* n (fact (1- n)))))

(defun choose (n r)
  "Compute the binomial coefficient of N and R"
  (/ (fact n)
     (fact (- n r))
     (fact r)))
