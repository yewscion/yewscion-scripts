(define-module (run-backups)
  :use-module (ice-9 ftw)
  :use-module (cdr255 userlib)
  :use-module (cdr255 combinators)
  :export (run-backups
           show-backups))
(define default-backup-directories
  (dereference-env-in-string
   "HOME"
   (string-append "$HOME/.local/bin\n$HOME/Archives\n$HOME/Books\n$HOME/Mail"
                  "\n$HOME/Mirrors\n$HOME/Music\n$HOME/Pictures\n"
                  "$HOME/Research\n$HOME/Videos")))
(define default-repository
  (dereference-env-in-string
   "HOME"
   "$HOME/Backups"))
(define* (construct-restic-call directories repository)
  (let ((directory-string (join-directories directories)))
    (string-append
     "restic -r "
     repository
     " backup "
     directory-string)))
(define* (procedure-wrapper procedure action #:rest args)
  (apply action (list (apply procedure args))))
(define* (show-backups #:key (directories
                            default-backup-directories)
                     (repository
                      default-repository))
  (procedure-wrapper construct-restic-call
                     display
                     directories
                     repository))
(define* (run-backups #:key (directories
                             default-backup-directories)
                      (repository
                       default-repository))
  (procedure-wrapper construct-restic-call
                     system
                     directories
                     repository))

(define (join-directories directories)
  (replace-regexp-in-string "\n" " " directories))
