(in-package #:draw)

(defmacro with-saved-state (&body body)
  "Execute the BODY and restore the state of rendering when complete."
  `(progn
     (require-with-page 'with-saved-state)
     (%with-saved-state *renderer* (lambda ()
                                     ,@body))))
