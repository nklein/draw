(in-package #:draw-backend)

(defgeneric %set-line-width (renderer width)
  (:documentation "This method sets the with of the lines used to outline paths."))

(defgeneric %set-rgb-stroke (renderer r g b)
  (:documentation "This method sets the color used to outline paths."))

(defgeneric %set-rgb-fill (renderer r g b)
  (:documentation "This method sets the color used to fill paths."))
