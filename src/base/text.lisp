(in-package #:draw)

(define-condition not-in-text-mode-error (error)
  ((method :initarg :method :reader not-in-text-mode-error-method)
   (arguments :initarg :arguments :reader not-in-text-mode-error-arguments))

  (:report (lambda (condition stream)
             (format stream "Attempted to invoke ~A with arguments ~S outside of IN-TEXT-MODE~%"
                     (not-in-text-mode-error-method condition)
                     (not-in-text-mode-error-arguments condition)))))


(defvar *text-mode-p* nil
  "Tracks whether we are currently in text mode.")

(defun require-text-mode (method &rest args)
  (unless *text-mode-p*
    (error 'not-in-text-mode-error :method method :arguments args)))

(defmacro in-text-mode (&body body)
  "Execute the BODY in text mode."
  `(let ((*text-mode-p* t))
     (%in-text-mode (renderer) (lambda ()
                                 ,@body))))

(declaim (inline draw-text))
(defun draw-text (string)
  "Renders the STRING at the current text position."
  (require-text-mode 'text-mode string)
  (%draw-text (renderer) string))

(declaim (inline move-text))
(defun move-text (nx ny)
  "Move reset the text position to NX horizontally and NY vertically."
  ;; The CL-PDF function calls its PDF:MOVE-TEXT arguments DX and DY.
  ;; That implies it should add them to the current (x,y) text
  ;; position.  However, it seems to just set the position instead.
  (require-text-mode 'move-text nx ny)
  (%move-text (renderer) nx ny))
