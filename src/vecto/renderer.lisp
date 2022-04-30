(in-package #:draw-vecto)

(defclass vecto-renderer (renderer)
  ((dpi :initarg :dpi :reader %dpi)
   (page-color :initarg :page-color :reader %page-color)
   (font :initform nil :accessor %font)
   (font-size :initform nil :accessor %font-size))
  (:default-initargs :dpi 300
                     :page-color '(1.0 1.0 1.0 1.0))
  (:documentation "The VECTO-RENDERER class implements DRAW functionality using VECTO"))

(defmethod initialize-instance :after ((renderer vecto-renderer) &key &allow-other-keys)
  (setf (%supports-multipage-documents renderer) nil))

(defun font (renderer)
  (first (%font renderer)))

(defun (setf font) (new-font renderer)
  (let ((cur (%font renderer)))
    (if cur
        (setf (car cur) new-font)
        (push new-font (%font renderer)))))

(defun push-font (renderer)
  (let ((cur (font renderer)))
    (when cur
      (push cur (%font renderer)))))

(defun pop-font (renderer)
  (pop (%font renderer)))


(defun font-size (renderer)
  (or (first (%font-size renderer))
      1))

(defun (setf font-size) (new-font-size renderer)
  (let ((cur (%font-size renderer)))
    (if cur
        (setf (car cur) new-font-size)
        (push new-font-size (%font-size renderer)))))

(defun push-font-size (renderer)
  (let ((cur (font-size renderer)))
    (when cur
      (push cur (%font-size renderer)))))

(defun pop-font-size (renderer)
  (pop (%font-size renderer)))
