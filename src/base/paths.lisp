(in-package #:draw)

(declaim (inline move-to))
(defun move-to (x y)
  "Moves the location where the path will begin to the coordinates (X,Y)."
  (%move-to (renderer) x y))

(declaim (inline line-to))
(defun line-to (x y)
  "Adds a line in the path from the current location to (X,Y)."
  (%line-to (renderer) x y))

(declaim (inline rectangle))
(defun rectangle (x y w h &key radius)
  "Adds a rectangle to the path at the given (X,Y) with width W and height H. If RADIUS is positive, then the corners of the rectangle are rounded with that radius."
  (if (and (numberp radius)
           (plusp radius))
      (%rounded-rectangle (renderer) x y w h radius)
      (%rectangle (renderer) x y w h)))

(declaim (inline circle))
(defun circle (x y radius)
  "Adds a circle to the path centered at (X,Y) and having the given RADIUS."
  (%circle (renderer) x y radius))

(declaim (inline close-path))
(defun close-path ()
  "Closes the current subpath without yet coloring it."
  (%close-path (renderer)))

(declaim (inline close-and-fill))
(defun close-and-fill ()
  "Closes the path and fills it using the current fill color."
  (%close-and-fill (renderer)))

(declaim (inline close-and-stroke))
(defun close-and-stroke ()
  "Closes the path and outlines it using the current stroke color."
  (%close-and-stroke (renderer)))

(declaim (inline close-fill-and-stroke))
(defun close-fill-and-stroke ()
  "Closes the path, fills it using the current fill color, and outlines it using the current stroke color."
  (%close-fill-and-stroke (renderer)))
