;;;; draw.asd

(asdf:defsystem #:draw
  :description "Common interface to both CL-PDF and Vecto"
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20220428"
  :license "UNLICENSE"
  :depends-on ((:version #:draw-backend "0.1.20220428"))
  :components
  ((:static-file "README.md")
   (:static-file "UNLICENSE.txt")
   (:module "src/base"
    :components ((:file "package")
                 (:file "errors" :depends-on ("package"))
                 (:file "renderer" :depends-on ("package"
                                                "errors"))
                 (:file "style" :depends-on ("package"
                                             "errors"
                                             "renderer"))
                 (:file "transform" :depends-on ("package"
                                                 "errors"
                                                 "renderer"))
                 (:file "paths" :depends-on ("package"
                                             "errors"
                                             "renderer"))
                 (:file "text" :depends-on ("package"
                                            "errors"
                                            "renderer"))
                 (:file "font" :depends-on ("package"
                                            "errors"
                                            "renderer"))
                 (:file "state" :depends-on ("package"
                                             "errors"
                                             "renderer"))
                 (:file "page" :depends-on ("package"
                                            "errors"
                                            "renderer"))))))
