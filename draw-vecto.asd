;;;; draw-vecto.asd

(asdf:defsystem #:draw-vecto
  :description "Backend using Vecto for DRAW."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20220426"
  :license "UNLICENSE"
  :depends-on ((:version #:draw-backend "0.1.20220426")
               #:vecto)
  :components
  ((:static-file "README.md")
   (:static-file "UNLICENSE.txt")
   (:module "src/vecto"
    :components ((:file "package")
                 (:file "renderer" :depends-on ("package"))
                 (:file "style" :depends-on ("package"
                                             "renderer"))
                 (:file "transform" :depends-on ("package"
                                                 "renderer"))
                 (:file "paths" :depends-on ("package"
                                             "renderer"))
                 (:file "font" :depends-on ("package"
                                            "renderer"))
                 (:file "state" :depends-on ("package"
                                             "renderer"))))))
