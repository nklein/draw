(in-package #:draw-backend)

(defmacro with-saved-state (&body body)
  `(%with-saved-state *renderer* (lambda () ,@body)))
