#!/usr/bin/env -S guile -e main -s
-e main -s
!#
(use-modules (generate-localweb))
(define (main args)
  (let ((arguments (cdr args)))
    (cond ((not (equal? (length arguments) 0))
           (display (string-append
                     "Usage: generate-localweb\n\n"

                     "Explanation of Configuration:\n\n"

                     "Will create and update a local archive at ~/LocalWeb\n"
                     "of all of the sites listed (one per line) in \n"
                     "~/LocalWeb/mirrorlist.txt. No other configuration has\n"
                     "been added yet."

                     "This program is entirely written in GNU Guile Scheme,\n"
                     "and You are welcome to change it how You see fit.\n\n"

                     "Guile Online Help: <https://www.gnu.org/software/guile/>\n"
                     "Local Online Help: 'info guile'\n")))
          (else (generate-localweb)))))
