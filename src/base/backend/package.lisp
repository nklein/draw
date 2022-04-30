(defpackage #:draw-backend
  (:use :cl)

  (:export :renderer
           :%supports-multipage-documents
           :text-location
           :set-text-location)

  (:export :%with-document
           :%with-page
           :%write-document)

  (:export :%set-line-width
           :%set-rgb-stroke
           :%set-rgb-fill)

  (:export :%translate
           :%rotate
           :%scale)

  (:export :%move-to
           :%line-to
           :%rectangle
           :%rounded-rectangle
           :%circle
           :%close-path
           :%close-and-fill
           :%close-and-stroke
           :%close-fill-and-stroke)

  (:export :%load-ttf-font
           :%get-font
           :%set-font
           :%get-char-size
           :%get-font-descender
           :%get-kerning)

  (:export :%in-text-mode
           :%draw-text
           :%move-text)

  (:export :%with-saved-state))
