;;; examples.lisp -- Example use cases for exercises in LOL.

(defmacro! nif (o!expr pos zero neg)
  "Numeric 3-way conditional based on the result of O!EXPR.

If O!EXPR is positive, expands POS.
If O!EXPR is negative, expands NEG.
If O!EXPR is zero, expands ZERO."
  `(cond ((plusp  ,g!expr) ,pos)
         ((zerop  ,g!expr) ,zero)
         ((minusp ,g!expr) ,neg)))
