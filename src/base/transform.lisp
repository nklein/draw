(in-package #:draw)

(declaim (inline translate))
(defun translate (dx dy)
  "Shift the canvas DX points horizontally and DY points vertically."
  (%translate (renderer) dx dy))

(declaim (inline rotate))
(defun rotate (degrees)
  "Rotate the canvas the given number of DEGREES."
  (%rotate (renderer) degrees))

(declaim (inline scale))
(defun scale (sx sy)
  "Scale the canvas by SX horizontally and SY vertically."
  (%scale (renderer) sx sy))
