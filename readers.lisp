;;; readers.lisp -- Read macros for special literal forms.

(defun |#"-reader| (stream sub-char num-arg)
  "Read in #\"string\"# forms as \"string\" forms"
  (let (chars)
    (do ((prev (read-char stream) curr)
         (curr (read-char stream) (read-char stream)))
        ((and (char= prev #\") (char= curr #\#)))
      (push prev chars))
    (coerce (nreverse chars) 'string)))

(set-dispatch-macro-character #\# #\" #'|#"-reader|)
