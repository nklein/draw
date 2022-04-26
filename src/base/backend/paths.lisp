(in-package #:draw-backend)

(defun close-path (renderer)
  (multiple-value-bind (x y) (start-of-path renderer)
    (set-location renderer x y)))

(defgeneric %move-to (renderer x y)
  (:method :before ((renderer renderer) x y)
           (set-start-of-path renderer x y)
           (set-location renderer x y))
  (:documentation "This method moves the location where the path will begin to the coordinates (X,Y)."))

(defgeneric %line-to (renderer x y)
  (:method :before ((renderer renderer) x y)
           (set-location renderer x y))
  (:documentation "This adds a line in the path from the current location to (X,Y)."))

(defgeneric %rectangle (renderer x y w h)
  (:documentation "This adds a rectangle to the path at the given (X,Y) with width W and height H."))

(defgeneric %rounded-rectangle (renderer x y w h radius)
  (:documentation "This adds a rectangle with rounded corners to the path at the given (X,Y) with width W and height H. The corners have the given RADIUS."))

(defgeneric %circle (renderer x y radius)
  (:documentation "This adds a circle to the path centered at (X,Y) and having the given RADIUS."))

(defgeneric %close-and-fill (renderer)
  (:method :around ((renderer renderer))
           (unwind-protect
                (call-next-method renderer)
             (close-path renderer)))
  (:documentation "This closes the path and fills it using the current fill color."))

(defgeneric %close-and-stroke (renderer)
  (:method :around ((renderer renderer))
           (unwind-protect
                (call-next-method renderer)
             (close-path renderer)))
  (:documentation "This closes the path and outlines it using the current stroke color."))

(defgeneric %close-fill-and-stroke (renderer)
  (:method :around ((renderer renderer))
           (unwind-protect
                (call-next-method renderer)
             (close-path renderer)))
  (:documentation "This closes the path, fills it using the current fill color, and outlines it using the current stroke color."))
