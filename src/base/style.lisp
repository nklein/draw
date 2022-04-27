(in-package #:draw)

(declaim (inline set-line-width))
(defun set-line-width (width)
  (%set-line-width (renderer) width))

(declaim (inline set-rgb-stroke))
(defun set-rgb-stroke (r g b)
  (%set-rgb-stroke (renderer) r g b))

(declaim (inline set-rgb-fill))
(defun set-rgb-fill (r g b)
  (%set-rgb-fill (renderer) r g b))
