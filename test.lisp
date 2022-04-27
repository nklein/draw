(let ((path #P"./*.asd"))
  (loop :for asd :in (directory path)
     :when (ignore-errors (load asd))
     :collect asd))


(ql:quickload '(:draw :draw-pdf :cl-pdf))


(defun test ()

  (draw:set-rgb-fill 0.6 0.9 0.6)
  (draw:set-rgb-stroke 0.9 0.6 0.6)
  (draw:set-line-width 1)

  (draw:with-saved-state
    (draw:move-to 10 10)
    (draw:line-to 10 40)
    (draw:line-to 30 40)
    (draw:close-and-stroke))

  (draw:with-saved-state
    (draw:move-to 15 10)
    (draw:line-to 35 10)
    (draw:line-to 35 40)
    (draw:close-and-fill))

  (draw:with-saved-state
    (draw:move-to 40 10)
    (draw:line-to 40 40)
    (draw:line-to 60 40)
    (draw:close-fill-and-stroke))

  (draw:with-saved-state
    (draw:set-rgb-fill 0.6 0.8 0.9)
    (draw:set-rgb-stroke 0.4 0.1 0.1)
    (draw:set-line-width 3)
    (draw:circle 80 20 10)
    (draw:close-fill-and-stroke))

  (draw:with-saved-state
    (draw:rectangle 10 50 50 30)
    (draw:rectangle 70 50 50 30 :radius 5)
    (draw:close-fill-and-stroke)))

(defun test-pdf (output-filename width height)
  (pdf:with-document ()
    (pdf:with-page (:bounds (vector 0 0 width height))
      (draw-pdf:with-pdf-renderer ()
        (test)))
    (pdf:write-document output-filename)))

(defun test-all (output-filename width height)
  (flet ((file (ext)
           (merge-pathnames (make-pathname :type ext)
                            output-filename)))
    (test-pdf (file "pdf") width height)))

(test-all "/tmp/draw-test.out" 130 90)
