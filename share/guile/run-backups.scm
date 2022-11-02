(define-module (run-backups)
  :use-module (ice-9 ftw)
  :use-module (cdr255 userlib)
  :export (run-backups))

(define default-backup-directories
  (map (lambda (x)
         (dereference-env-in-string
          "HOME"
          x))
       '("$HOME/.local/bin"
         "$HOME/Archives"
         "$HOME/Books"
         "$HOME/Mail"
         "$HOME/Mirrors"
         "$HOME/Music"
         "$HOME/Pictures"
         "$HOME/Research"
         "$HOME/Videos")))
(define default-repository
  (dereference-env-in-string
   "HOME"
   "$HOME/Backups"))
(define* (construct-restic-call #:key (directories
                                       default-backup-directories)
                                (repository
                                 default-repository))
  (string-append
   "restic -r "
   repository
   " backup "
   (string-join directories)))
