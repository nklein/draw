(in-package #:draw-vecto)

(defclass vecto-renderer (renderer)
  ((font :initform nil :accessor %font)
   (font-size :initform nil :accessor %font-size))
  (:documentation "The VECTO-RENDERER class implements DRAW functionality using VECTO"))

(defun font (renderer)
  (first (%font renderer)))

(defun (setf font) (new-font renderer)
  (let ((cur (%font renderer)))
    (if cur
        (setf (car cur) new-font)
        (push new-font (%font renderer)))))

(defun push-font (renderer)
  (let ((cur (%font renderer)))
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
  (let ((cur (%font-size renderer)))
    (when cur
      (push cur (%font-size renderer)))))

(defun pop-font-size (renderer)
  (pop (%font-size renderer)))


(defmacro with-vecto-renderer ((&key (dpi 300)) &body body)
  (declare (ignorable dpi))
  (let ((dpi-var (gensym "DPI"))
        (scale (gensym "SCALE")))
    `(let ((,dpi-var ,dpi))
       (assert (and (numberp ,dpi-var)
                    (plusp ,dpi-var))
               () "Must give the :DPI argument a number")
       (let ((,scale (/ ,dpi-var 72)))
         (clear-font-cache)
         (with-renderer () (make-instance 'vecto-renderer)
           (vecto:with-graphics-state
             (vecto:set-rgb-fill 1.0 1.0 1.0)
             (vecto:clear-canvas)
             (vecto:scale ,scale ,scale)
             ,@body))))))
