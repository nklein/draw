(in-package #:draw-vecto)

(defmethod %translate ((renderer vecto-renderer) dx dy)
  (vecto:translate dx dy))

(defmethod %rotate ((renderer vecto-renderer) degrees)
  (vecto:rotate-degrees degrees))

(defmethod %scale ((renderer vecto-renderer) sx sy)
  (vecto:scale sx sy))
