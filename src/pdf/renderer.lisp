(in-package #:draw-pdf)

(defclass pdf-renderer (renderer)
  ((font-map :initform (make-hash-table :test 'equal) :reader %font-map))
  (:documentation "The PDF-RENDERER class implements DRAW functionality using CL-PDF"))

(defun pdf-font-name (renderer handle)
  (let ((lc-handle (string-downcase handle)))
    (gethash lc-handle (%font-map renderer) lc-handle))
  handle)

(defun (setf pdf-font-name) (name renderer handle)
  (setf (gethash (string-downcase handle) (%font-map renderer)) name))
