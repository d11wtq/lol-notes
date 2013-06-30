;;; timers.lisp --- Timer-related stuff, like sleep.

(defmacro sleep-for (n unit)
  "Sleep for a period of time given by N and UNIT"
  `(sleep (time-interval ,n ,unit)))

(defmacro time-interval (n unit)
  "Expands to a number of seconds for N and UNIT"
  `(* ,(case unit
         (s 1)
         (m 60)
         (h 3600)
         (d 86400))
      ,n))
