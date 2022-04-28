(in-package #:draw)

(declaim (inline load-ttf-font))
(defun load-ttf-font (font-pathname &optional handle)
  "Load the TTF font from the FONT-PATHNAME for use later with GET-FONT. The HANDLE that GET-FONT will expect is the font's ZPB-TTF:POSTSCRIPT-NAME unless you specify a HANDLE here."
  (require-with-document 'load-ttf-font font-pathname handle)
  (%load-ttf-font *renderer* font-pathname handle))

(declaim (inline get-font))
(defun get-font (handle)
  "Get the font given its HANDLE."
  (require-with-page 'get-font handle)
  (%get-font *renderer* handle))

(declaim (inline set-font))
(defun set-font (font font-size)
  (require-text-mode 'set-font font font-size)
  (%set-font *renderer* font font-size))
