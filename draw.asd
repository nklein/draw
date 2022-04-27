;;;; draw.asd

(asdf:defsystem #:draw
  :description "Common interface to both CL-PDF and Vecto"
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20220426"
  :license "UNLICENSE"
  :depends-on ((:version #:draw-backend "0.1.20220426"))
  :components
  ((:static-file "README.md")
   (:static-file "UNLICENSE.txt")
   (:module "src/base"
    :components ((:file "package")
                 (:file "style" :depends-on ("package"))
                 (:file "transform" :depends-on ("package"))
                 (:file "paths" :depends-on ("package"))
                 (:file "font" :depends-on ("package"))
                 (:file "state" :depends-on ("package"))))))
