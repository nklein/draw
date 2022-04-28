(in-package #:draw-pdf)

(defmethod %with-document ((renderer pdf-renderer) arguments thunk)
  (destructuring-bind (&key author
                            title
                            keywords
                            subject
                       &allow-other-keys) arguments
    (pdf:with-document (:author author
                        :title title
                        :keywords keywords
                        :subject subject)
      (funcall thunk))))

(defmethod %with-page ((renderer pdf-renderer) arguments thunk)
  (destructuring-bind (&key (bounds pdf:*default-page-bounds*)
                       &allow-other-keys) arguments
    (pdf:with-page (:bounds bounds)
      (funcall thunk))))
