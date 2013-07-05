;;; timers.lisp --- Timer-related stuff, like sleep.

(defmacro! definterval (name base-n &rest subunits)
  "Macro to define an interval macro."
  `(defmacro ,(symb name '-interval) (,g!n ,g!unit)
     `(* ,(case ,g!unit
            (,base-n 1)
            ,@(group subunits 2))
         ,,g!n)))

(defmacro sleep-for (n unit)
  "Sleep for a period of time given by N and UNIT"
  `(sleep (time-interval ,n ,unit)))

;;; -- Use cases

(definterval time s
  m 60
  h 3600
  d 86400)
