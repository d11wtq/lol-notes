;;; macros.lisp --- Macros for special forms.

(defmacro defmacro/g! (name args &rest body)
  "Special DEFMACRO that replaces G! symbols with GENSYMs"
  (let ((syms (remove-duplicates
               (remove-if-not #'g!-symbol-p
                              (flatten body)))))
    `(defmacro ,name ,args
       (let ,(mapcar
              (lambda (s)
                `(,s (gensym ,(subseq (symbol-name s) 2))))
              syms)
         ,@body))))

(defmacro defmacro! (name args &rest body)
  "Special DEFMACRO that memoizes expansions on O! symbols"
  (let* ((os (remove-if-not #'o!-symbol-p args))
         (gs (mapcar #'o!-symbol-to-g!-symbol os)))
    `(defmacro/g! ,name ,args
       `(let ,(mapcar #'list (list ,@gs) (list ,@os))
          ,(progn ,@body)))))

;;; --- Private API

(defun g!-symbol-p (s)
  "Test if S is a symbol starting with 'G!'"
  (!-symbol-p #\G s))

(defun o!-symbol-p (s)
  "Test if S is a symbol starting with 'O!'"
  (!-symbol-p #\O s))

(defun !-symbol-p (char s)
  "Test if S is a symbol starting with CHAR!"
  (and (symbolp s)
       (> (length (symbol-name s)) 2)
       (string= (symbol-name s)
                (format nil "~c!" (char-upcase char))
                :start1 0
                :end1   2)))

(defun o!-symbol-to-g!-symbol (s)
  "Convert an O! symbol to a G! symbol of the same name"
  (symb "G!" (subseq (symbol-name s) 2)))
