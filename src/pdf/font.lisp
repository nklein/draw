(in-package #:draw-pdf)

(defmethod %load-ttf-font ((renderer pdf-renderer) font-pathname handle)
  (let ((metrics (pdf:load-ttf-font font-pathname)))
    (when metrics
      (let* ((name (pdf:font-name metrics))
             (handle (or handle
                         name)))
        (setf (pdf-font-name renderer handle) name)))))

(defmethod %get-font ((renderer pdf-renderer) handle)
  (pdf:get-font (pdf-font-name renderer handle)))

(defmethod %set-font ((renderer pdf-renderer) font font-size)
  (pdf:set-font font font-size))
