(in-package #:draw-vecto)

(defmethod %with-document ((renderer vecto-renderer) arguments thunk)
  (destructuring-bind (&key width
                            height
                       &allow-other-keys) arguments
    (let* ((scale (/ (%dpi renderer) 72))
           (width (round (* scale width)))
           (height (round (* scale height))))
      (vecto:with-canvas (:width width :height height)
        (vecto:with-graphics-state
          (vecto:set-rgb-fill 1.0 1.0 1.0)
          (vecto:clear-canvas))
        (vecto:scale scale scale)
        (funcall thunk)))))

(defmethod %with-page ((renderer vecto-renderer) arguments thunk)
  (declare (ignore renderer arguments))
  (funcall thunk))
