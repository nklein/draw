;;;; draw-backend.asd

(asdf:defsystem #:draw-backend
  :description "Common interface to both CL-PDF and Vecto"
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20220426"
  :license "UNLICENSE"
  :depends-on ()
  :components
  ((:static-file "README.md")
   (:static-file "UNLICENSE.txt")
   (:module "src/base/backend"
    :components ((:file "package")
                 (:file "point-stack" :depends-on ("package"))
                 (:file "renderer" :depends-on ("package"
                                                "point-stack"))
                 (:file "style" :depends-on ("package"
                                             "renderer"))
                 (:file "paths" :depends-on ("package"
                                             "renderer"))
                 (:file "state" :depends-on ("package"
                                             "renderer"))))))
