;;; nlet.lisp --- A named, recursive let.

(defmacro! nlet (name letargs &rest body)
  "Defines a named let, like a function with default args."
  (let ((gs (mapcar (lambda (s) (gensym)) letargs)))
    `(macrolet ((,name ,gs
       `(progn
          (psetq
           ,@(apply #'nconc
                    (mapcar #'list
                            ',(mapcar #'car letargs)
                            (list ,@gs))))
          (go ,',g!n))))
       (block ,g!b
         (let ,letargs
           (tagbody
            ,g!n (return-from ,g!b
                   (progn ,@body))))))))
