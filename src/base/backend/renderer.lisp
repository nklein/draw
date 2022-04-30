(in-package #:draw-backend)

(defclass renderer ()
  ((start-of-path :initform nil :accessor %start-of-path)
   (location :initform nil :accessor %location)
   (text-location :initform nil :accessor %text-location)
   (supports-multipage-documents :initform t
                                 :accessor %supports-multipage-documents))
  (:documentation "The RENDERER class forms the base class for all DRAW backends."))

(defun set-start-of-path (renderer x y)
  (setf (point-stack (%start-of-path renderer)) (cons x y)))

(defun start-of-path (renderer)
  (point-stack (%start-of-path renderer)))

(defun push-start-of-path (renderer)
  (multiple-value-bind (x y) (start-of-path renderer)
    (push (cons x y) (%start-of-path renderer))))

(defun pop-start-of-path (renderer)
  (pop (%start-of-path renderer)))


(defun set-location (renderer x y)
  (setf (point-stack (%location renderer)) (cons x y)))

(defun location (renderer)
  (point-stack (%location renderer)))

(defun push-location (renderer)
  (multiple-value-bind (x y) (location renderer)
    (push (cons x y) (%location renderer))))

(defun pop-location (renderer)
  (pop (%location renderer)))


(defun set-text-location (renderer x y)
  (setf (point-stack (%text-location renderer)) (cons x y)))

(defun text-location (renderer)
  (point-stack (%text-location renderer)))

(defun push-text-location (renderer)
  (multiple-value-bind (x y) (text-location renderer)
    (push (cons x y) (%text-location renderer))))

(defun pop-text-location (renderer)
  (pop (%text-location renderer)))
