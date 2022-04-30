(defpackage #:draw
  (:use :cl :draw-backend)

  (:export :with-renderer
           :supports-multipage-documents)

  (:export :with-document
           :with-page
           :write-document
           :*page-number*
           :page-numbered-filename)

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

  (:export :load-ttf-font
           :get-font
           :set-font
           :get-char-size
           :get-font-descender
           :get-kerning)

  (:export :not-in-text-mode-error
           :not-in-text-mode-error-method
           :not-in-text-mode-error-arguments
           :in-text-mode
           :draw-text
           :move-text)

  (:export :with-saved-state))
