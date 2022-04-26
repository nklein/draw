(let ((path #P"./*.asd"))
  (loop :for asd :in (directory path)
     :when (ignore-errors (load asd))
     :collect asd))


(ql:quickload '(:draw :draw-pdf :cl-pdf))


(defun test ()
  (progn
    (draw:move-to 10 10)
    (draw:line-to 10 40)
    (draw:line-to 30 40)
    (draw:close-and-stroke))

  (progn
    (draw:move-to 15 10)
    (draw:line-to 35 10)
    (draw:line-to 35 40)
    (draw:close-and-fill))

  (progn
    (draw:move-to 40 10)
    (draw:line-to 40 40)
    (draw:line-to 60 40)
    (draw:close-fill-and-stroke))

  (progn
    (draw:rectangle 10 50 50 30)
    (draw:rectangle 70 50 50 30 :radius 5)
    (draw:close-fill-and-stroke))

  (progn
    (draw:circle 80 20 10)
    (draw:close-fill-and-stroke))
  )

(defun test-pdf (output-filename)
  (pdf:with-document ()
    (pdf:with-page (:bounds (vector 0 0 (* 4 72) (* 4 72)))
      (pdf:set-rgb-fill 0.6 0.9 0.6)
      (pdf:set-rgb-stroke 0.9 0.6 0.6)
      (pdf:set-line-width 1)
      (draw-pdf:with-pdf-renderer ()
        (test)))
    (pdf:write-document output-filename)))

(defun test-all (output-filename)
  (flet ((file (ext)
           (merge-pathnames (make-pathname :type ext)
                            output-filename)))
    (test-pdf (file "pdf"))))

(test-all "/tmp/draw-test.out")
