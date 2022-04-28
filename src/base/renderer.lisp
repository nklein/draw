(in-package #:draw)

(defvar *renderer* nil
  "The RENDERER instance in use.")

(defmacro with-renderer ((renderer-class &rest arguments) &body body)
  "This macro constructs an instance of the given RENDERER-CLASS using the given ARGUMENTS and uses it as the renderer for the BODY."
  `(progn
     (forbid-nested-with-renderer 'with-renderer ',renderer-class ',arguments)
     (let ((*renderer* (make-instance ',renderer-class ,@arguments)))
       (check-type *renderer* renderer)
       ,@body)))
