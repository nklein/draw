(defpackage #:draw-backend
  (:use :cl)

  (:export :renderer
           :with-renderer)

  (:export :%set-line-width
           :%set-rgb-stroke
           :%set-rgb-fill)

  (:export :%move-to
           :%line-to
           :%rectangle
           :%rounded-rectangle
           :%circle
           :%close-and-fill
           :%close-and-stroke
           :%close-fill-and-stroke)

  (:export :%with-saved-state))
