(in-package #:draw)

(defvar *in-document-p* nil
  "Tracks if we are currently in a document.")

(defvar *in-page-p* nil
  "Tracks if we are currently in a page.")

(defvar *page-number* nil
  "Track the current page number.")

(defmacro with-document ((&rest arguments &key &allow-other-keys) &body body)
  "Run the BODY in a new document context made with the given ARGUMENTS."
  (let ((argv (gensym "ARGV")))
    `(let ((,argv (list ,@arguments)))
       (forbid-nested-with-document 'with-document ,argv)
       (let ((*in-document-p* t)
             (*page-number* 0))
         (%with-document *renderer* ,argv (lambda ()
                                             ,@body))))))

(defmacro with-page ((&rest arguments &key &allow-other-keys) &body body)
  "Run the BODY in a new page context made with the given ARGUMENTS."
  (let ((argv (gensym "ARGV")))
    `(let ((,argv (list ,@arguments)))
       (require-with-document 'with-page ,argv)
       (forbid-nested-with-page 'with-page ,argv)
       (let ((*in-page-p* t))
         (%with-page *renderer* ,argv (lambda ()
                                        ,@body)
                     (incf *page-number*))))))

(defun page-numbered-filename (output-filename &optional (digits 1))
  (let* ((basename (pathname-name output-filename))
         (numbered-name (format nil "~A~V,'0D" basename digits *page-number*)))
    (make-pathname :name numbered-name :defaults output-filename)))

(defun write-document (output-filename)
  "Saves the current document to the OUTPUT-FILENAME with the appropriate extension."
  (require-with-document 'write-document output-filename)
  (%write-document *renderer* output-filename))
