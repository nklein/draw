(in-package #:draw-pdf)

(defmethod %load-ttf-font ((renderer pdf-renderer) font-pathname)
  (pdf:load-ttf-font font-pathname))

(defmethod %get-font ((renderer pdf-renderer) handle)
  (pdf:get-font handle))

(defmethod %set-font ((renderer pdf-renderer) font font-size)
  (pdf:set-font font font-size))
