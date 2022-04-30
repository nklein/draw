(in-package #:draw-vecto)

(define-condition font-not-found-error (error)
  ((handle :initarg :handle :reader font-not-found-error-handle))
  (:report (lambda (condition stream)
             (format stream "Unable to find a font with handle ~A"
                     (font-not-found-error-handle condition)))))

(defvar *font-loader-by-handle* nil)
(defvar *font-handle-by-pathname* nil)

(defun clear-font-cache ()
  (setf *font-loader-by-handle* (make-hash-table :test 'equal)
        *font-handle-by-pathname* (make-hash-table :test 'equal)))

(clear-font-cache)

(defun add-font-loader (handle pathname loader)
  (setf (gethash (namestring (truename pathname)) *font-handle-by-pathname*) handle
        (gethash handle *font-loader-by-handle*) loader)
  handle)

(defun get-handle (pathname)
  (gethash (namestring (truename pathname)) *font-handle-by-pathname*))

(defun get-font-loader (handle)
  (or (gethash (string-downcase handle) *font-loader-by-handle*)
      (error 'font-not-found-error :handle handle)))

(defun preload-ttf-font (font-pathname handle)
  (or (get-handle font-pathname)
      (let ((loader (zpb-ttf:open-font-loader font-pathname)))
        (when loader
          (let ((handle (string-downcase (or handle
                                             (zpb-ttf:postscript-name loader)))))
            (add-font-loader handle font-pathname loader))))))

(declaim (inline ensure-font-size))
(defun ensure-font-size (font-size)
  (or (when (and (numberp font-size)
                 (plusp font-size))
        font-size)
      1))

(declaim (inline get-scaling-for-font))
(defun get-scaling-for-font (font font-size)
  (let ((font-size (ensure-font-size font-size)))
    (/ font-size (zpb-ttf:units/em font) 1.0)))

(defmethod %load-ttf-font ((renderer vecto-renderer) font-pathname handle)
  (preload-ttf-font font-pathname handle))

(defmethod %get-font ((renderer vecto-renderer) handle)
  (get-font-loader handle))

(defmethod %set-font ((renderer vecto-renderer) font font-size)
  (let ((font-size (ensure-font-size font-size)))
    (setf (font renderer) font
          (font-size renderer) font-size)
    (vecto:set-font font font-size)))

(defmethod %get-char-size ((renderer vecto-renderer) char-or-code font font-size)
  (let* ((scale (get-scaling-for-font font font-size))
         (glyph (zpb-ttf:find-glyph char-or-code font))
         (bbox (zpb-ttf:bounding-box glyph)))
    (values (* scale (zpb-ttf:advance-width glyph))
            (* scale (aref bbox 3))
            (* scale (aref bbox 1)))))

(defmethod %get-font-descender ((renderer vecto-renderer) font font-size)
  (let ((scale (get-scaling-for-font font font-size)))
    (* scale (zpb-ttf:descender font))))

(defmethod %get-kerning ((renderer vecto-renderer) char1 char2 font font-size)
  (let ((scale (get-scaling-for-font font font-size))
        (glyph1 (zpb-ttf:find-glyph char1 font))
        (glyph2 (zpb-ttf:find-glyph char2 font)))
    (* scale (zpb-ttf:kerning-offset glyph1 glyph2 font))))
