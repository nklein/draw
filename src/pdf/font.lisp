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

(defmethod %get-char-size ((renderer pdf-renderer) char-or-code font font-size)
  (pdf:get-char-size char-or-code font font-size))

(defmethod %get-font-descender ((renderer pdf-renderer) font font-size)
  (pdf:get-font-descender font font-size))

(defmethod %get-kerning ((renderer pdf-renderer) char1 char2 font font-size)
  (pdf:get-kerning char1 char2 font font-size))
