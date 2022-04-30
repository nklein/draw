(in-package #:draw-backend)

(defgeneric %in-text-mode (renderer thunk)
  (:method :before ((renderer renderer) thunk)
           (declare (ignore thunk))
           (multiple-value-bind (x y) (location renderer)
             (set-text-location renderer x y)))
  (:documentation "Execute the given THUNK in text mode."))

(defgeneric %draw-text (renderer string)
  (:documentation "This method renders the STRING at the current text position."))

(defgeneric %move-text (renderer dx dy)
  (:documentation "This method moves the current text position by DX horizontally and DY vertically."))
