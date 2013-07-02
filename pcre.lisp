;;; pcre.lisp -- Reader macros for PCRE literals.

(defun pcre/segment-reader (stream delim n)
  "Read a unit of a PCRE match, or replacement.
When N = 1, finds a /match/ pattern.
When N = 2, finds a /match/replacement/ pattern."
  (unless (zerop n)
    (let (chars)
      (do ((curr (read-char stream) (read-char stream)))
          ((char= delim curr))
        (push curr chars))
      (cons (coerce (nreverse chars) 'string)
            (pcre/segment-reader stream delim (1- n))))))

#+cl-ppcre
(defmacro! pcre/match-lambda-form (o!args)
  "Expands to a lambda that applies CL-PPCRE:SCAN"
  ``(lambda (,',g!str)
      (cl-ppcre:scan ,(car ,g!args)
                     ,',g!str)))

#+cl-ppcre
(defmacro! pcre/replace-lambda-form (o!args)
  "Expands to a lambda that applies CL-PPCRE:REGEX-REPLACE"
  ``(lambda (,',g!str)
      (cl-ppcre:regex-replace ,(car ,g!args)
                              ,',g!str
                              ,(cadr ,g!args))))

#+cl-ppcre
(defun |#~-reader| (stream sub-char num-arg)
  "Read a full PCRE literal, such as #~m/id=\d+/"
  (declare (ignore sub-char num-arg))
  (let ((mode (read-char stream)))
    (case mode
      (#\m (pcre/match-lambda-form
            (pcre/segment-reader stream
                                 (read-char stream) 1)))
      (#\s (pcre/replace-lambda-form
            (pcre/segment-reader stream
                                 (read-char stream) 2)))
      (otherwise (error "Unknown #~~ form: ~c" mode)))))

#+cl-ppcre
(set-dispatch-macro-character #\# #\~ #'|#~-reader|)
