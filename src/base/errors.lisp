(in-package #:draw)

(define-condition nested-with-renderer-error (error)
  ((method :initarg :method :reader nested-with-renderer-error-method)
   (arguments :initarg :arguments :reader nested-with-renderer-error-arguments))

  (:report (lambda (condition stream)
             (format stream "Attempted to invoke ~A with arguments ~S while inside a WITH-RENDERER~%"
                     (nested-with-renderer-error-method condition)
                     (nested-with-renderer-error-arguments condition)))))

(define-condition nested-with-document-error (error)
  ((method :initarg :method :reader nested-with-document-error-method)
   (arguments :initarg :arguments :reader nested-with-document-error-arguments))

  (:report (lambda (condition stream)
             (format stream "Attempted to invoke ~A with arguments ~S while inside a WITH-DOCUMENT~%"
                     (nested-with-document-error-method condition)
                     (nested-with-document-error-arguments condition)))))

(define-condition not-with-document-error (error)
  ((method :initarg :method :reader not-with-document-error-method)
   (arguments :initarg :arguments :reader not-with-document-error-arguments))

  (:report (lambda (condition stream)
             (format stream "Attempted to invoke ~A with arguments ~S outside of WITH-DOCUMENT~%"
                     (not-with-document-error-method condition)
                     (not-with-document-error-arguments condition)))))

(define-condition nested-with-page-error (error)
  ((method :initarg :method :reader nested-with-page-error-method)
   (arguments :initarg :arguments :reader nested-with-page-error-arguments)
   (page-number :initarg :page-number :reader nested-with-page-error-page-number))

  (:report (lambda (condition stream)
             (format stream "Attempted to invoke ~A with arguments ~S while inside a WITH-PAGE on page ~D~%"
                     (nested-with-page-error-method condition)
                     (nested-with-page-error-arguments condition)
                     (nested-with-page-error-page-number condition)))))

(define-condition not-with-page-error (error)
  ((method :initarg :method :reader not-with-page-error-method)
   (arguments :initarg :arguments :reader not-with-page-error-arguments))

  (:report (lambda (condition stream)
             (format stream "Attempted to invoke ~A with arguments ~S outside of WITH-PAGE~%"
                     (not-with-page-error-method condition)
                     (not-with-page-error-arguments condition)))))

(define-condition not-in-text-mode-error (error)
  ((method :initarg :method :reader not-in-text-mode-error-method)
   (arguments :initarg :arguments :reader not-in-text-mode-error-arguments))

  (:report (lambda (condition stream)
             (format stream "Attempted to invoke ~A with arguments ~S outside of IN-TEXT-MODE~%"
                     (not-in-text-mode-error-method condition)
                     (not-in-text-mode-error-arguments condition)))))

(defun forbid-nested-with-renderer (method &rest arguments)
  (when *renderer*
    (error 'nested-with-renderer-error :method method :arguments arguments)))

(defun forbid-nested-with-document (method &rest arguments)
  (when *in-document-p*
    (error 'nested-with-document-error :method method :arguments arguments)))

(defun require-with-document (method &rest arguments)
  (unless *in-document-p*
    (error 'not-with-document-error :method method :arguments arguments)))

(defun forbid-nested-with-page (method &rest arguments)
  (when *in-page-p*
    (error 'nested-with-page-error :method method :arguments arguments :page-number *page-number*)))

(defun require-with-page (method &rest arguments)
  (unless *in-page-p*
    (error 'not-with-page-error :method method :arguments arguments)))


(defun require-text-mode (method &rest args)
  (unless *text-mode-p*
    (error 'not-in-text-mode-error :method method :arguments args)))
