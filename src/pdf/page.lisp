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

(defmethod %with-page ((renderer pdf-renderer) arguments thunk page-number)
  (destructuring-bind (&key (bounds pdf:*default-page-bounds*)
                       &allow-other-keys) arguments

    ;; The PDF:WITH-PAGE will increment the page number, so we are
    ;; setting it to one less than requested now.  The PDF:WITH-PAGE
    ;; initialization does some checks after it increments the
    ;; page-number so we are setting it now instead of inside the
    ;; PDF:WITH-PAGE scope.
    (setf pdf:*page-number* (1- page-number))
    (pdf:with-page (:bounds bounds)
      (funcall thunk))))

(defmethod %write-document ((renderer pdf-renderer) output-filename)
  (pdf:write-document (make-pathname :type "pdf"
                                     :defaults output-filename)))
