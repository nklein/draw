;;;; draw-vecto.asd

(asdf:defsystem #:draw-vecto
  :description "Backend using Vecto for DRAW."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.2.20220430"
  :license "UNLICENSE"
  :depends-on ((:version #:draw-backend "0.2.20220430")
               #:vecto
               #:zpb-ttf)
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
                 (:file "text" :depends-on ("package"
                                            "renderer"))
                 (:file "font" :depends-on ("package"
                                            "renderer"))
                 (:file "state" :depends-on ("package"
                                             "renderer"))
                 (:file "page" :depends-on ("package"
                                            "renderer"))))))
