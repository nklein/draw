(in-package #:draw)

(defmacro with-saved-state (&body body)
  "Execute the BODY and restore the state of rendering when complete."
  `(%with-saved-state (renderer) (lambda () ,@body)))
