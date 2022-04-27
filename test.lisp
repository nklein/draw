(ql:quickload '(:draw :draw-pdf :draw-vecto :cl-pdf :vecto))

(defun test ()
  (let ((fonts '(#P"/Users/pat/Library/Fonts/NotoSans-Light.ttf")))
    (dolist (font fonts)
      (draw:load-ttf-font font)))

  (draw:set-rgb-fill 0.6 0.9 0.6)
  (draw:set-rgb-stroke 0.9 0.6 0.6)
  (draw:set-line-width 0.5)

  (draw:with-saved-state
    (draw:translate -40 40)
    (draw:rotate -85)
    (draw:scale 0.75 1.25)
    (draw:translate 0 35)

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

    (draw:translate 28 0)
    (draw:with-saved-state
      (draw:move-to 10 10)
      (draw:line-to 10 40)
      (draw:line-to 30 40)
      (draw:close-fill-and-stroke)))

  (draw:with-saved-state
    (draw:translate 95 25)

    (draw:move-to 0 0)
    (draw:line-to 10 0)
    (draw:line-to 10 10)
    (draw:close-path)

    (draw:move-to 15 0)
    (draw:line-to 15 10)
    (draw:line-to 25 0)
    (draw:close-path)

    (draw:close-and-stroke))

  (draw:with-saved-state
    (draw:set-rgb-fill 0.6 0.8 0.9)
    (draw:set-rgb-stroke 0.4 0.1 0.1)
    (draw:set-line-width 3)
    (draw:circle 80 20 10)
    (draw:close-fill-and-stroke))

  (draw:with-saved-state
    (draw:rectangle 10 50 50 30)
    (draw:close-fill-and-stroke)
    (draw:translate 60 0)
    (draw:rectangle 10 50 50 30 :radius 5)
    (draw:close-fill-and-stroke))

  (draw:with-saved-state
    (let ((font (draw:get-font "NotoSans-Light")))
      (draw:set-font font 24))))

(defun test-pdf (output-filename width height)
  (pdf:with-document ()
    (pdf:with-page (:bounds (vector 0 0 width height))
      (draw-pdf:with-pdf-renderer ()
        (test)))
    (pdf:write-document output-filename)))

(defun test-vecto (output-filename width height dpi)
  (let ((scale (/ dpi 72)))
    (vecto:with-canvas (:width (round (* scale width)) :height (round (* scale height)))
      (draw-vecto:with-vecto-renderer (:dpi dpi)
        (test))
      (vecto:save-png output-filename))))

(defun test-all (output-filename width height dpi)
  (flet ((file (ext)
           (make-pathname :type ext :defaults output-filename)))
    (test-pdf (file "pdf") width height)
    (test-vecto (file "png") width height dpi)))

(let ((dpi 300))
  (test-all "/tmp/draw-test.out" 130 90 dpi))
