(in-package #:draw)

(declaim (inline set-line-width))
(defun set-line-width (width)
  "Set the line width to WIDTH points."
  (%set-line-width (renderer) width))

(declaim (inline set-rgb-stroke))
(defun set-rgb-stroke (r g b)
  "Set the outline color to R, G, B."
  (%set-rgb-stroke (renderer) r g b))

(declaim (inline set-rgb-fill))
(defun set-rgb-fill (r g b)
  "Set the fill color to R, G, B."
  (%set-rgb-fill (renderer) r g b))
