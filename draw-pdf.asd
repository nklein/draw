;;;; draw-pdf.asd

(asdf:defsystem #:draw-pdf
  :description "Backend using CL-PDF for DRAW."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20220426"
  :license "UNLICENSE"
  :depends-on ((:version #:draw-backend "0.1.20220426")
               #:cl-pdf)
  :components
  ((:static-file "README.md")
   (:static-file "UNLICENSE.txt")
   (:module "src/pdf"
    :components ((:file "package")
                 (:file "renderer" :depends-on ("package"))
                 (:file "paths" :depends-on ("package"
                                             "renderer"))
                 (:file "state" :depends-on ("package"
                                             "renderer"))))))
