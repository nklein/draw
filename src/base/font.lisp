(in-package #:draw)

(declaim (inline load-ttf-font))
(defun load-ttf-font (font-pathname &optional handle)
  "Load the TTF font from the FONT-PATHNAME for use later with GET-FONT. The HANDLE that GET-FONT will expect is the font's ZPB-TTF:POSTSCRIPT-NAME unless you specify a HANDLE here."
  (require-with-document 'load-ttf-font font-pathname handle)
  (%load-ttf-font *renderer* font-pathname handle))

(declaim (inline get-font))
(defun get-font (handle)
  "Get the font given its HANDLE."
  (require-with-document 'get-font handle)
  (%get-font *renderer* handle))

(declaim (inline set-font))
(defun set-font (font &optional font-size)
  (require-text-mode 'set-font font font-size)
  (%set-font *renderer* font font-size))

(declaim (inline get-char-size))
(defun get-char-size (char-or-code font &optional font-size)
  (require-with-document 'get-char-size char-or-code font font-size)
  (%get-char-size *renderer* char-or-code font font-size))

(declaim (inline get-font-descender))
(defun get-font-descender (font &optional font-size)
  (require-with-document 'get-font-descender font font-size)
  (%get-font-descender *renderer* font font-size))

(declaim (inline get-kerning))
(defun get-kerning (char1 char2 font &optional font-size)
  (require-with-document 'get-font-kerning char1 char2 font font-size)
  (%get-kerning *renderer* char1 char2 font font-size))
