;;; pcre.lisp -- Example usage of the pcre reader macros.

(#~m/foo\d+/ "There's a foo99 in here")
; => t

(#~s/are (\d+) dogs/are \1 cats/ "There are 99 dogs in here")
; => "There are 99 cats in here"
