(in-package #:draw-pdf)

(defmethod %move-to ((renderer pdf-renderer) x y)
  (pdf:move-to x y))

(defmethod %line-to ((renderer pdf-renderer) x y)
  (pdf:line-to x y))

(defmethod %rectangle ((renderer pdf-renderer) x y w h)
  (pdf:rectangle x y w h))

(defmethod %rounded-rectangle ((renderer pdf-renderer) x y w h radius)
  (pdf:rectangle x y w h :radius radius))

(defmethod %circle ((renderer pdf-renderer) x y radius)
  (pdf:circle x y radius))

(defmethod %close-path ((renderer pdf-renderer))
  (pdf:close-path))

(defmethod %close-and-fill ((renderer pdf-renderer))
  (pdf:close-and-fill))

(defmethod %close-and-stroke ((renderer pdf-renderer))
  (pdf:close-and-stroke))

(defmethod %close-fill-and-stroke ((renderer pdf-renderer))
  (pdf:close-fill-and-stroke))
