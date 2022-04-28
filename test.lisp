(ql:quickload '(:draw :draw-pdf :draw-vecto :cl-pdf :vecto :md5 :external-program))

(defun preload-fonts ()
  (let ((fonts '(#P"/Users/pat/Library/Fonts/NotoSans-Light.ttf")))
    (dolist (font fonts)
      (draw:load-ttf-font font))))

(defun test-rotation-translation-fill-and-stroke ()
  (draw:rotate (- 90 56))
  (draw:scale 0.75 0.75)
  (draw:translate 35 -12)

  (draw:with-saved-state
    (draw:move-to 0 0)
    (draw:line-to 0 30)
    (draw:line-to 20 30)
    (draw:close-and-stroke))

  (draw:with-saved-state
    (draw:move-to 5 0)
    (draw:line-to 25 0)
    (draw:line-to 25 30)
    (draw:close-and-fill))

  (draw:translate 30 0)
  (draw:with-saved-state
    (draw:move-to 0 0)
    (draw:line-to 0 30)
    (draw:line-to 20 30)
    (draw:close-fill-and-stroke)))

(defun test-subpaths ()
  (draw:move-to 0 0)
  (draw:line-to 10 0)
  (draw:line-to 10 10)
  (draw:close-path)

  (draw:move-to 12 0)
  (draw:line-to 12 10)
  (draw:line-to 22 0)
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
  (draw:circle 65 20 10)
  (draw:close-fill-and-stroke))

(defun test-rectangles ()
  (draw:rectangle 10 50 50 30)
  (draw:close-fill-and-stroke)
  (draw:translate 60 0)
  (draw:rectangle 10 50 50 30 :radius 5)
  (draw:close-fill-and-stroke))

(defun test (output-filename width height)
  (draw:with-document (:author "CL-DRAW"
                       :title (format nil "Test image: ~A" (pathname-name output-filename))
                       :width width
                       :height height)
    (preload-fonts)
    (draw:with-page ()
      (draw:set-rgb-fill 0.6 0.9 0.6)
      (draw:set-rgb-stroke 0.9 0.6 0.6)
      (draw:set-line-width 0.5)

      (draw:with-saved-state
        (test-rotation-translation-fill-and-stroke))

      (draw:with-saved-state
        (draw:translate 85 20)
        (test-subpaths))

      (draw:with-saved-state
        (test-circles))

      (draw:with-saved-state
        (test-rectangles))

      (draw:with-saved-state
        (draw:translate 50 35)
        (test-text)))
    (unless (draw:supports-multipage-documents)
      (draw:write-document (draw:page-numbered-filename output-filename 3)))

    (draw:with-page ()
      (draw:with-saved-state
        (draw:translate 50 35)
        (test-text)))
    (unless (draw:supports-multipage-documents)
      (draw:write-document (draw:page-numbered-filename output-filename 3)))

    (when (draw:supports-multipage-documents)
      (draw:write-document output-filename))))

(defun test-pdf (output-filename width height)
  (draw:with-renderer (draw-pdf:pdf-renderer)
    (test output-filename width height)))

(defun test-vecto (output-filename width height dpi)
  (draw:with-renderer (draw-vecto:vecto-renderer :dpi dpi
                                                 :page-color-not '(1.0 1.0 1.0 1.0))
    (draw-vecto:clear-font-cache)
    (test output-filename width height)))

(defun test-all (output-filename width height dpi)
  (test-pdf output-filename width height)
  (test-vecto output-filename width height dpi))

(defun make-images ()
  (test-all #P"/tmp/draw-test.out" 130 90 200))

(defun validate ()
  (ignore-errors (delete-file #P"/tmp/draw-test.pdf"))
  (ignore-errors (delete-file #P"/tmp/draw-test001.png"))
  (ignore-errors (delete-file #P"/tmp/draw-test002.png"))
  (ignore-errors (delete-file #P"/tmp/scrubbed-draw-test.pdf"))

  (make-images)

  ;; We need to scrub out the creation date in the PDF if we hope
  ;; to still have the same checksum we did last time.
  (external-program:run "sed" '("-e" "/^\\/CreationDate (D:[0-9]*)/d")
                        :input #P"/tmp/draw-test.pdf"
                        :output #P"/tmp/scrubbed-draw-test.pdf"
                        :if-output-exists :supersede)

  (assert (equalp (md5:md5sum-file #P"/tmp/scrubbed-draw-test.pdf")
                  (vector 14 202 175 235 235 83 151 209 204 79 177 173 191 110 25 13)))
  (assert (equalp (md5:md5sum-file #P"/tmp/draw-test001.png")
                  (vector 122 145 188 193 17 90 2 13 153 54 249 195 238 255 96 217)))
  (assert (equalp (md5:md5sum-file #P"/tmp/draw-test002.png")
                  (vector 171 52 8 240 248 75 229 22 56 184 161 243 75 129 124 58))))


(validate)
