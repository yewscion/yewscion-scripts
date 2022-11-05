(define-module (tests-cdr255)
  #:use-module (srfi srfi-64)
  #:use-module (yewscion display-encoded-wifi))

(module-define! (resolve-module '(srfi srfi-64))
		'test-log-to-file #f)

(test-begin "test-hello-world")

(test-equal "Hello World!\n" "Hello World!\n")

(test-end "test-hello-world")


;; Local Variables:
;; mode: scheme
;; End:
