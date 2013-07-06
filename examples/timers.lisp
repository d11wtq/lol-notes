;;; timers.lisp --- Timer-related stuff, like sleep.

(defun unit-multiplier (unit subunits)
  "Helper function to multiply along a chain of units."
  (let ((spec (find unit subunits :key #'car)))
    (if (null spec)
        (error "Can't find unit ~s" unit)
      (let ((multiplier (cadr spec)))
        (if (listp multiplier)
            (* (car multiplier)
               (unit-multiplier (cadr multiplier) subunits))
          multiplier)))))

;; FIXME: Compute units at read-time (better error checking)
(defmacro! definterval (name base-unit &rest subunits)
  "Macro to define an interval macro."
  `(let ((,g!subunits ',(cons (list base-unit 1)
                              (group subunits 2))))
     (defmacro ,(symb name '-interval) (,g!n ,g!unit)
       `(* ,(unit-multiplier ,g!unit ,g!subunits)
           ,,g!n))))

(defmacro sleep-for (n unit)
  "Sleep for a period of time given by N and UNIT"
  `(sleep (time-interval ,n ,unit)))

;;; -- Use cases

(definterval time s
  m 60
  h 3600
  d 86400)
