(in-package #:draw-vecto)

(defmethod %with-document ((renderer vecto-renderer) arguments thunk)
  (destructuring-bind (&key width
                            height
                       &allow-other-keys) arguments
    (let* ((scale (/ (%dpi renderer) 72))
           (width (round (* scale width)))
           (height (round (* scale height))))
      (vecto:with-canvas (:width width :height height)
        (vecto:scale scale scale)
        (funcall thunk)))))

(defun erase-page (renderer)
  (let ((page-color (or (%page-color renderer)
                        '(0.0 0.0 0.0 0.0))))
    (vecto:with-graphics-state
      (ecase (length page-color)
        (3 (apply #'vecto:set-rgb-fill page-color))
        (4 (apply #'vecto:set-rgba-fill page-color)))
      (vecto:clear-canvas))))

(defmethod %with-page ((renderer vecto-renderer) arguments thunk)
  (destructuring-bind (&key &allow-other-keys) arguments
    (vecto:with-graphics-state
      (erase-page renderer)
      (funcall thunk))))

(defmethod %write-document ((renderer vecto-renderer) output-filename)
  (vecto:save-png (make-pathname :type "png"
                                 :defaults output-filename)))
