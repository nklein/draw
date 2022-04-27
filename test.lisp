(ql:quickload '(:draw :draw-pdf :draw-vecto :cl-pdf :vecto))

(defun preload-fonts ()
  (let ((fonts '(#P"/Users/pat/Library/Fonts/NotoSans-Light.ttf")))
    (dolist (font fonts)
      (draw:load-ttf-font font))))

(defun test-rotation-translation-fill-and-stroke ()
  (draw:translate -40 45)
  (draw:rotate -68)
  (draw:scale 0.75 1.25)
  (draw:translate 35 25)

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

  (draw:translate 30 0)
  (draw:with-saved-state
    (draw:move-to 10 10)
    (draw:line-to 10 40)
    (draw:line-to 30 40)
    (draw:close-fill-and-stroke)))

(defun test-subpaths ()
  (draw:translate 95 20)

  (draw:move-to 0 0)
  (draw:line-to 10 0)
  (draw:line-to 10 10)
  (draw:close-path)

  (draw:move-to 15 0)
  (draw:line-to 15 10)
  (draw:line-to 25 0)
  (draw:close-path)

  (draw:close-and-stroke))

(defun test-text ()
  (draw:with-saved-state
    (draw:set-line-width 0.25)
    (draw:set-rgb-stroke 0.5 0.5 0.8)
    (loop :for x :to 50 :by 5
       :do (draw:rectangle x -2.25 2 2)
       :do (draw:rectangle x  7.75 2 2))
    (draw:close-and-stroke))

  (draw:in-text-mode
    (let ((font (draw:get-font "NotoSans-Light")))
      (draw:set-rgb-fill 0.2 0.2 0.2)
      (draw:set-font font 10)
      (draw:draw-text "Text")
      (draw:with-saved-state
        (draw:set-font font 3)
        (draw:set-rgb-fill 0.6 0.2 0.2)
        (draw:move-text -3 3)
        (draw:draw-text "xyz"))
      (draw:draw-text "123")
      (draw:draw-text "abc"))))

(defun test-circles ()
  (draw:set-rgb-fill 0.6 0.8 0.9)
  (draw:set-rgb-stroke 0.4 0.1 0.1)
  (draw:set-line-width 3)
  (draw:circle 80 20 10)
  (draw:close-fill-and-stroke))

(defun test-rectangles ()
  (draw:rectangle 10 50 50 30)
  (draw:close-fill-and-stroke)
  (draw:translate 60 0)
  (draw:rectangle 10 50 50 30 :radius 5)
  (draw:close-fill-and-stroke))

(defun test ()
  (preload-fonts)

  (draw:set-rgb-fill 0.6 0.9 0.6)
  (draw:set-rgb-stroke 0.9 0.6 0.6)
  (draw:set-line-width 0.5)

  (draw:with-saved-state
    (test-rotation-translation-fill-and-stroke))

  (draw:with-saved-state
    (test-subpaths))

  (draw:with-saved-state
    (test-circles))

  (draw:with-saved-state
    (test-rectangles))

  (draw:with-saved-state
    (draw:translate 65 35)
    (test-text)))

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

(let ((dpi 200))
  (test-all "/tmp/draw-test.out" 130 90 dpi))
