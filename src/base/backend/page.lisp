(in-package #:draw-backend)

(defgeneric %with-document (renderer arguments thunk)
  (:method :before ((renderer renderer) arguments thunk)
           (declare (ignore arguments thunk))
           (setf (%start-of-path renderer) nil
                 (%location renderer) nil
                 (%text-location renderer) nil))
  (:documentation "This method invokes the given THUNK in a new document context made with the given ARGUMENTS."))

(defgeneric %with-page (renderer arguments thunk)
  (:method :before ((renderer renderer) arguments thunk)
           (declare (ignore arguments thunk))
           (setf (%start-of-path renderer) nil
                 (%location renderer) nil
                 (%text-location renderer) nil))
  (:documentation "This method invokes the given THUNK in a new page context made with the given ARGUMENTS."))

(defgeneric %write-document (renderer output-filename)
  (:documentation "This method saves the current document to the OUTPUT-FILENAME with the appropriate extension."))
