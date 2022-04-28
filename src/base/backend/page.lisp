(in-package #:draw-backend)

(defgeneric %with-document (renderer arguments thunk)
  (:method :before ((renderer renderer) arguments thunk)
           (declare (ignore arguments thunk))
           (setf (%start-of-path renderer) nil
                 (%location renderer) nil
                 (%text-location renderer) nil))
  (:documentation "This method invokes the given THUNK in a new document context made with the given ARGUMENTS."))

(defgeneric %with-page (renderer arguments thunk page-number)
  (:method :before ((renderer renderer) arguments thunk page-number)
           (declare (ignore arguments thunk page-number))
           (setf (%start-of-path renderer) nil
                 (%location renderer) nil
                 (%text-location renderer) nil))
  (:documentation "This method invokes the given THUNK in a new page context made with the given ARGUMENTS. The page should have the given PAGE-NUMBER."))

(defgeneric %write-document (renderer output-filename)
  (:documentation "This method saves the current document to the OUTPUT-FILENAME with the appropriate extension."))
