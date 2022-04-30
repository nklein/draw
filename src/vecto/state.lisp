(in-package #:draw-vecto)

(defmethod %with-saved-state ((renderer vecto-renderer) thunk)
  (push-font renderer)
  (push-font-size renderer)
  (unwind-protect
       (vecto:with-graphics-state
         (funcall thunk))
    (pop-font-size renderer)
    (pop-font renderer)))
