;;; sharp-backquote.lisp -- Form interpolation/formatting.

(defun |#`-reader| (stream sub-char num-args)
  "Wrap backquote with a lambda definining implicit a1..an.
Each argument is expanded with the macro.

Example: (#2`'(,a1 ,a2) 42 7) ; '(42 7)"
  (declare (ignore sub-char))
  (let ((num-args (or num-args 1)))
    `(lambda ,(loop for i from 1 to num-args
                    collect (symb 'a i))
       ,(funcall (get-macro-character #\`) stream nil))))

(set-dispatch-macro-character #\# #\` #'|#`-reader|)
