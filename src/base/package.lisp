(defpackage #:draw
  (:use :cl :draw-backend)

  (:export :set-line-width
           :set-rgb-stroke
           :set-rgb-fill)

  (:export :translate
           :rotate
           :scale)

  (:export :move-to
           :line-to
           :rectangle
           :rounded-rectangle
           :circle
           :close-path
           :close-and-fill
           :close-and-stroke
           :close-fill-and-stroke)

  (:export :with-saved-state))
