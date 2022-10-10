#!/usr/bin/env -S guile -e main -s
-e main -s
!#
(use-modules (generate-localweb)    ; The library for this project.
             (ice-9 getopt-long))   ; For CLI Options and Flags.
(define (main args)
  (let* ((options (getopt-long args option-spec))
         (version (option-ref options 'version #f))
         (listing (option-ref options 'listing #f))
         (execute (option-ref options 'execute #f))
         (help (or
                (option-ref options 'help #f)
                (= (length args) 0)))
         (display))
    (when help
      (display help-string)
      (quit))
    (when version
      (display version-string)
      (quit))
    (when listing
      (display (generate-command-string))
      (quit))
    (when execute
      (generate-localweb)
      (quit))))
(define option-spec
  '((version (single-char #\v) (value #f))
    (help (single-char #\h) (value #f))
    (execute (single-char #\x) (value #f))
    (listing (single-char #\l) (value #f))))
(define help-string
  (string-append
   "Usage: generate-localweb [-lhv]\n\n"
   
   "Actions:\n\n"
   
   "  -l, --listing:       Print the command string that would be\n"
   "                         used to call httrack with the current\n"
   "                         configuration to the screen, for\n"
   "                         testing purposes.\n"
   "  -x, --execute:       Actually Generate the LocalWeb,\n"
   "                         according to the current"
   "                         configuration.\n"
   "  -h, --help:          Display this help message.\n"
   "  -v, --version:       Display version information.\n"
   
   "Explanation of Configuration:\n\n"
   
   "Will create and update a local archive at ~/LocalWeb\n"
   "of all of the sites listed (one per line) in \n"
   "~/LocalWeb/mirrorlist.txt. No other configuration has\n"
   "been added yet."
   
   "This program is entirely written in GNU Guile Scheme,\n"
   "and You are welcome to change it how You see fit.\n\n"
   
   "Guile Online Help: <https://www.gnu.org/software/guile/>\n"
   "Local Online Help: 'info guile'\n"))
(define version-string
  "generate-localweb v0.1.0, part of yewscion-scripts v0.1.0.")
