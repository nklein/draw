(in-package #:draw-vecto)

(defmethod %in-text-mode ((renderer vecto-renderer) thunk)
  (funcall thunk))

(defmethod %draw-text ((renderer vecto-renderer) string)
  (let* ((font (font renderer))
         (font-size (font-size renderer))
         (scale (/ font-size (zpb-ttf:units/em font)))
         (box (zpb-ttf:string-bounding-box string font))
         (sbox (map 'vector (lambda (x) (* scale x)) box))
         (left (elt sbox 0))
         (right (elt sbox 2)))
    (multiple-value-bind (x y) (text-location renderer)
      (vecto:draw-string x y string)
      (set-text-location renderer (+ x right left) y))))

(defmethod %move-text ((renderer vecto-renderer) nx ny)
  (set-text-location renderer nx ny))
