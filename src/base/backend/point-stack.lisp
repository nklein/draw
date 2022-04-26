(in-package #:draw-backend)

(define-setf-expander point-stack (stack &environment env)
  "Set the first element of a stack of points (including corner case where no points exist yet)."
  (multiple-value-bind (tmps vals newval setter getter)
      (get-setf-expansion stack env)
    (let ((pt (gensym "PT"))
          (head (gensym "HEAD")))
      (values tmps
              vals
              `(,pt)
              `(let ((,head ,getter))
                 (if ,head
                     (rplaca ,head ,pt)
                     (let ((,(first newval) (list ,pt)))
                       ,setter))
                 ,pt)
              `(or (first ,getter)
                   (cons 0 0))))))

(defun point-stack (stack)
  (values (or (car (first stack)) 0)
          (or (cdr (first stack)) 0)))
