(in-package #:draw)

(declaim (inline load-ttf-font))
(defun load-ttf-font (font-pathname)
  (%load-ttf-font (renderer) font-pathname))

(declaim (inline get-font))
(defun get-font (handle)
  (%get-font (renderer) handle))

(declaim (inline set-font))
(defun set-font (font font-size)
  (%set-font (renderer) font font-size))
