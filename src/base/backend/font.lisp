(in-package #:draw-backend)

(defgeneric %load-ttf-font (renderer font-pathname handle)
  (:documentation "This method loads a TrueType font from the given FONT-PATHNAME for later use and returns a handle to it. If HANDLE is non-null, it is used. Otherwise, the handle is determined from the font name."))

(defgeneric %get-font (renderer handle)
  (:documentation "This method fetches a loaded font given its HANDLE."))

(defgeneric %set-font (renderer font font-size)
  (:documentation "This method sets the given FONT as the current font for rendering at the given FONT-SIZE."))
