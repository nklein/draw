(in-package #:draw)

(defvar *in-document-p* nil
  "Tracks if we are currently in a document.")

(defvar *page-number* nil
  "Track the current page number.")

(defmacro with-document ((&rest arguments &key &allow-other-keys) &body body)
  (let ((argv (gensym "ARGV")))
    `(let ((,argv (list ,@arguments)))
       (forbid-nested-with-document 'with-document ,argv)
       (let ((*in-document-p* t)
             (*page-number* 0))
         (%with-document *renderer* ,argv (lambda ()
                                             ,@body))))))

(defmacro with-page ((&rest arguments &key &allow-other-keys) &body body)
  (let ((argv (gensym "ARGV")))
    `(let ((,argv (list ,@arguments)))
       (require-with-document 'with-page ,argv)
       (forbid-nested-with-page 'with-page ,argv)
       (let ((*page-number* (1+ *page-number*)))
         (%with-page *renderer* ,argv (lambda ()
                                        ,@body))))))
