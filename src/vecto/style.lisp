(in-package #:draw-vecto)

(defmethod %set-line-width ((renderer vecto-renderer) width)
  (vecto:set-line-width width))

(defmethod %set-rgb-stroke ((renderer vecto-renderer) r g b)
  (vecto:set-rgb-stroke r g b))

(defmethod %set-rgb-fill ((renderer vecto-renderer) r g b)
  (vecto:set-rgb-fill r g b))
