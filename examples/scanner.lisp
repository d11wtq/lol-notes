;;; scanner.lisp --- Scan for a keyword in a chunked string

;; This function serves to show off closure state.
(defun block-scanner (keyword)
  "Make a closure accepting str chunksm testing for KEYWORD."
  (let* ((keyword-chars (coerce keyword 'list))
         (to-match-chars keyword-chars))
    (lambda (str-chunk)
      (let ((chars (coerce str-chunk 'list)))
        (dolist (c chars)
          (unless (null to-match-chars)
            (setq to-match-chars
                  (if (char= c (car to-match-chars))
                      (cdr to-match-chars)
                    keyword-chars))))
        (null to-match-chars)))))
