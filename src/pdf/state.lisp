(in-package #:draw-pdf)

(defmethod %with-saved-state ((renderer pdf-renderer) thunk)
  (pdf:with-saved-state
    (funcall thunk)))
