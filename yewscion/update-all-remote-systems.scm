(define-module (yewscion update-all-remote-systems)
  :use-module (srfi srfi-9)
  :use-module (cdr255 combinators)
  :export (update-all-remote-systems
           update-all-remote-systems-custom
           make-remote-system
           remote-system-hostname
           remote-system-url
           remote-system-port
           remote-system?))

(define-record-type <remote-system>
  (make-remote-system hostname url port)
  remote-system?
  (hostname remote-system-hostname)
  (url remote-system-url)
  (port remote-system-port))

(define default-guix-pull-command
  "guix pull -v4")

(define default-guix-home-reconfigure-command
  "guix home reconfigure ~/Documents/guix-home/home-configuration.scm")

(define (remote-system->ssh-call remote-system)
    (string-append "ssh "
                 (remote-system-url remote-system)
                 " -p"
                 (number->string (remote-system-port remote-system))
                 " -- "))

(define (build-command-string remote-system command)
  (string-append (remote-system->ssh-call remote-system)
                 command))

(define show-command-string
  ((bluebird display build-command-string)))

(define run-command-string
  ((bluebird system build-command-string)))

(define (update-remote-system system)
  (run-command-string system default-guix-pull-command)
  (run-command-string system default-guix-home-reconfigure-command))

(define (update-all-remote-systems list-of-systems)
  (for-each update-remote-system
            list-of-systems))

(define (update-remote-system-custom system
                                     pull-command
                                     reconfigure-command)
  (run-command-string system pull-command)
  (run-command-string system reconfigure-command))

(define (update-all-remote-systems-custom list-of-systems
                                          pull-command
                                          reconfigure-command)
  (for-each (lambda (x)
              (update-remote-system-custom x
                                           pull-command
                                           reconfigure-command))
            list-of-systems))
