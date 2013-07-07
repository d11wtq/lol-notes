;;; dlambda.lisp -- Message-dispatching lambda.

(defmacro! dlambda (&rest ds)
  "Dispatches messages to several internal lambdas.

Example: ((dlambda
            (:a (x) (* 2 x))
            (:b 7))
          :a 4) ; 8"
  `(lambda (&rest ,g!args)
     (case (car ,g!args)
       ,@(mapcar (lambda (d)
                   `(,(if (eq t (car d))
                          t
                        `(,(car d)))
                     (apply (lambda ,@(cdr d))
                            ,(if (eq t (car d))
                                 g!args
                               `(cdr ,g!args)))))
                 ds))))
