#!/usr/bin/env -S guile -e main -s
-e main -s
!#
(use-modules (run-backups)          ; The library for this project.
             (ice-9 getopt-long))   ; For CLI Options and Flags.
(define (main args)
  (let* ((options (getopt-long args option-spec))
         (version (option-ref options 'version #f))
         (repository (option-ref options 'repository #f))
         (directories (option-ref options 'directories #f))
         (help (or
                (option-ref options 'help #f)
                (= (length args) 0))))
    (when help
      (display help-string)
      (quit))
    (when version
      (display version-string)
      (quit))
    (when (and (not repository) (not directories))
      (run-backups)
      (quit))
    (when (and repository directories)
      (run-backups #:repository repository #:directories directories)
      (quit))
    (when repository
      (run-backups #:repository repository)
      (quit))
    (when directories
      (run-backups #:directories directories)
      (quit))))
(define option-spec
  '((version (single-char #\v) (value #f))
    (help (single-char #\h) (value #f))
    (repositories (single-char #\r) (value #f))
    (directories (single-char #\d) (value #f))))
(define help-string
  (string-append
   "Usage: run-backups [-hv] [-r REPO] [-d DIRECTORIES]\n\n"
   
   "Actions:\n\n"
   
   "  -h, --help:          Display this help message.\n"
   "  -v, --version:       Display version information.\n"
   
   "Options:\n\n"
   "  -r, --repository:    Set the restic repository for\n"
   "                        use with this backup. Default:\n"
   "                        \"~/Backups\".\n"
   "  -d, --directories:   A newline-delimited list of\n"
   "                        directories to back up this time.\n"
   "                       Default: \"~/.local/bin\n                       "
   "          ~/Archives\n                                 ~/Books\n      "
   "                           ~/Mail\n                                 ~/M"
   "irrors\n                                 ~/Music\n                    "
   "             ~/Pictures\n                                 ~/Research\n"
   "                                 ~/Videos\".\n\n"
   

   "This program is entirely written in GNU Guile Scheme,\n"
   "and You are welcome to change it how You see fit.\n\n"
   
   "Guile Online Help: <https://www.gnu.org/software/guile/>\n"
   "Local Online Help: 'info guile'\n"))
(define version-string
  "run-backups v0.1.0, part of yewscion-scripts v0.1.0.")
