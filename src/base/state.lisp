(in-package #:draw)

(defmacro with-saved-state (&body body)
  `(%with-saved-state (renderer) (lambda () ,@body)))
