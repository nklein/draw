(in-package #:draw-backend)

(defgeneric %translate (renderer dx dy)
  (:documentation "This method shifts the canvas DX points horizontally and DY points vertically."))

(defgeneric %rotate (renderer d)
  (:documentation "This method rotates the canvas D degrees."))

(defgeneric %scale (renderer sx sy)
  (:documentation "This method scales the canvas by SX horizontally and SY vertically."))
