(in-package #:draw-pdf)

(defmethod %in-text-mode ((renderer pdf-renderer) thunk)
  (pdf:in-text-mode
    (funcall thunk)))

(defmethod %draw-text ((renderer pdf-renderer) string)
  (pdf:draw-text string))

(defmethod %move-text ((renderer pdf-renderer) nx ny)
  (pdf:move-text nx ny))
