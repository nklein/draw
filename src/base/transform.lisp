(in-package #:draw)

(declaim (inline translate))
(defun translate (dx dy)
  "Shift the canvas DX points horizontally and DY points vertically."
  (require-with-page 'translate dx dy)
  (%translate *renderer* dx dy))

(declaim (inline rotate))
(defun rotate (degrees)
  "Rotate the canvas the given number of DEGREES."
  (require-with-page 'rotate degrees)
  (%rotate *renderer* degrees))

(declaim (inline scale))
(defun scale (sx sy)
  "Scale the canvas by SX horizontally and SY vertically."
  (require-with-page 'scale sx sy)
  (%scale *renderer* sx sy))
