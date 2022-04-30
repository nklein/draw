(in-package #:draw-backend)

(defgeneric %with-saved-state (renderer thunk)
  (:method :around ((renderer renderer) thunk)
           (push-start-of-path renderer)
           (push-location renderer)
           (push-text-location renderer)
           (unwind-protect
                (call-next-method renderer thunk)
             (pop-text-location renderer)
             (pop-location renderer)
             (pop-start-of-path renderer)))
  (:documentation "This method saves the current state, executes the given THUNK, and restores the state."))
