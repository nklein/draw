(in-package #:draw-vecto)

(defmethod %move-to ((renderer vecto-renderer) x y)
  (vecto:move-to x y))

(defmethod %line-to ((renderer vecto-renderer) x y)
  (vecto:line-to x y))

(defmethod %rectangle ((renderer vecto-renderer) x y w h)
  (vecto:rectangle x y w h))

(defmethod %rounded-rectangle ((renderer vecto-renderer) x y w h radius)
  (vecto:rounded-rectangle x y w h radius radius))

(defmethod %circle ((renderer vecto-renderer) x y radius)
  (vecto:centered-circle-path x y radius))

(defmethod %close-and-fill ((renderer vecto-renderer))
  (vecto:close-subpath)
  (vecto:fill-path))

(defmethod %close-and-stroke ((renderer vecto-renderer))
  (vecto:close-subpath)
  (vecto:stroke))

(defmethod %close-fill-and-stroke ((renderer vecto-renderer))
  (vecto:close-subpath)
  (vecto:fill-and-stroke))
