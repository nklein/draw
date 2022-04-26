(in-package #:draw-pdf)

(defclass pdf-renderer ()
  ()
  (:documentation "The PDF-RENDERER class implements DRAW functionality using CL-PDF"))

(defmacro with-pdf-renderer (arg-list &body body)
  `(with-renderer () (make-instance 'pdf-renderer ,@arg-list)
     ,@body))
