;;; nlet.lisp --- A named, recursive let.

;; This named let is tail call optimized, since it uses
;; gotos instead of actual recursion on a stack.

(defmacro! nlet (name letargs &rest body)
  (let ((gs (mapcar (lambda (s) (gensym)) letargs)))
    `(macrolet ((,name ,gs
       `(progn
          (psetq ,@(apply #'nconc
                          (mapcar #'list
                                  ',(mapcar #'car letargs)
                                  (list ,@gs))))
          (go ,',g!n))))
       (block ,g!b
         (let ,letargs
           (tagbody
            ,g!n (return-from
                     ,g!b (progn ,@body))))))))
