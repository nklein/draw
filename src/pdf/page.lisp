(in-package #:draw-pdf)

(defmethod %with-document ((renderer pdf-renderer) arguments thunk)
  (destructuring-bind (&key author
                            title
                            keywords
                            subject
                            width
                            height
                       &allow-other-keys) arguments
    (let* ((bounds (if (and width height)
                       (vector 0 0 width height)
                       pdf:*default-page-bounds*))
           (pdf:*default-page-bounds* bounds))
      (pdf:with-document (:author author
                          :title title
                          :keywords keywords
                          :subject subject)
        (funcall thunk)))))

(defmethod %with-page ((renderer pdf-renderer) arguments thunk)
  (destructuring-bind (&key (bounds pdf:*default-page-bounds*)
                       &allow-other-keys) arguments
    (pdf:with-page (:bounds bounds)
      (funcall thunk))))

(defmethod %write-document ((renderer pdf-renderer) output-filename)
  (pdf:write-document (make-pathname :type "pdf"
                                     :defaults output-filename)))
