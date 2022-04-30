(in-package #:draw-pdf)

(defmethod %set-line-width ((renderer pdf-renderer) width)
  (pdf:set-line-width width))

(defmethod %set-rgb-stroke ((renderer pdf-renderer) r g b)
  (pdf:set-rgb-stroke r g b))

(defmethod %set-rgb-fill ((renderer pdf-renderer) r g b)
  (pdf:set-rgb-fill r g b))
