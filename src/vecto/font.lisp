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

(defmethod %load-ttf-font ((renderer vecto-renderer) font-pathname handle)
  (preload-ttf-font font-pathname handle))

(defmethod %get-font ((renderer vecto-renderer) handle)
  (get-font-loader handle))

(defmethod %set-font ((renderer vecto-renderer) font font-size)
  (setf (font renderer) font
        (font-size renderer) font-size)
  (vecto:set-font font font-size))
