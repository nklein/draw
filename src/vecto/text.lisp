(in-package #:draw-vecto)

(defmethod %in-text-mode ((renderer vecto-renderer) thunk)
  (funcall thunk))

(defun compute-string-advance (string font)
  (loop
     :for prev := nil :then glyph
     :for ch :across string
     :for glyph := (zpb-ttf:find-glyph ch font)
     :summing (+ (zpb-ttf:advance-width glyph)
                 (or (when prev
                       (zpb-ttf:kerning-offset prev glyph font))
                     0))))

(defmethod %draw-text ((renderer vecto-renderer) string)
  (let* ((font (font renderer))
         (font-size (font-size renderer))
         (scale (/ font-size (zpb-ttf:units/em font)))
         (advance (* (compute-string-advance string font)
                     scale)))

    (multiple-value-bind (x y) (text-location renderer)
      (vecto:draw-string x y string)
      (set-text-location renderer (+ x advance) y))))

(defmethod %move-text ((renderer vecto-renderer) nx ny)
  (set-text-location renderer nx ny))
