(in-package #:draw-backend)

(defgeneric %load-ttf-font (renderer font-pathname)
  (:documentation "This method loads a TrueType font from the given FONT-PATHNAME for later use and returns a HANDLE to it."))

(defgeneric %get-font (renderer handle)
  (:documentation "This method fetches a loaded font given its HANDLE."))

(defgeneric %set-font (renderer font font-size)
  (:documentation "This method sets the given FONT as the current font for rendering at the given FONT-SIZE."))
