;;; counter.lisp -- An object-oriented counter.

(defun make-counter ()
  "Create a new counter object with :INC, :DEC and :RESET."
  (let ((count 0))
    (dlambda
      (:inc () (incf count))
      (:dec () (decf count))
      (:reset () (setf count 0)))))
