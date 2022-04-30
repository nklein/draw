(in-package #:draw-backend)

(defgeneric %load-ttf-font (renderer font-pathname handle)
  (:documentation "This method loads a TrueType font from the given FONT-PATHNAME for later use and returns a handle to it. If HANDLE is non-null, it is used. Otherwise, the handle is determined from the font name."))

(defgeneric %get-font (renderer handle)
  (:documentation "This method fetches a loaded font given its HANDLE."))

(defgeneric %set-font (renderer font font-size)
  (:documentation "This method sets the given FONT as the current font for rendering at the given FONT-SIZE."))

(defgeneric %get-char-size (renderer char-or-code font font-size)
  (:documentation "This method gets the (VALUES WIDTH ASCENDER DESCENDER) for the given CHAR-OR-CODE in the given FONT at the given FONT-SIZE. The CHAR-OR-CODE should either be a character like #\\X or a character code like (CHAR-CODE #\\X)."))

(defgeneric %get-font-descender (renderer font font-size)
  (:documentation "This method gets the size of the descender for the given FONT at the given FONT-SIZE"))

(defgeneric %get-kerning (renderer char1 char2 font font-size)
  (:documentation "This method gets the kerning adjustment for putting CHAR2 after CHAR1 in the given FONT at tthe given FONT-SIZE"))
