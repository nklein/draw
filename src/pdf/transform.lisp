(in-package #:draw-pdf)

(defmethod %translate ((renderer pdf-renderer) dx dy)
  (pdf:translate dx dy))

(defmethod %rotate ((renderer pdf-renderer) degrees)
  (pdf:rotate degrees))

(defmethod %scale ((renderer pdf-renderer) sx sy)
  (pdf:scale sx sy))
