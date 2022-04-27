(in-package #:draw-vecto)

(defmethod %with-saved-state ((renderer vecto-renderer) thunk)
  (vecto:with-graphics-state
    (funcall thunk)))
