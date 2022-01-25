#!/usr/bin/env -S guile -e main -s
-e main -s
!#
(use-modules (display-encoded-wifi))
(define (main args)
  (let ((arguments (cdr args))
        (path (string-split (getenv "PATH") (lambda (x) (eqv? x #\:)))))
    (cond ((not (equal? (length arguments) 0))
           (display (string-append
                     "Usage: display-encoded-wifi\n\n"

                     "Explanation of Arguments:\n\n"

                     "  There are no arguments for this command.\n\n"

                     "This program depends on nmcli, grep, sed, and sha1sum.\n\n"

                     "This program is entirely written in GNU Guile Scheme,\n"
                     "and You are welcome to change it how You see fit.\n\n"

                     "Guile Online Help: <https://www.gnu.org/software/guile/>\n"
                     "Local Online Help: 'info guile'\n")))
          ((or
            (not (search-path path "nmcli"))
            (not (search-path path "sed"))
            (not (search-path path "grep"))
            (not (search-path path "sha1sum")))
           (display (string-append
                     "ERROR: One or more of the following programs was not found\n"
                     "       in Your $PATH. Please ensure they are all installed\n"
                     "       before using this program.\n\n"

                     "- nmcli (NetworkManager)\n"
                     "- sed (coreutils)\n"
                     "- grep (coreutils)\n"
                     "- sha1sum (coreutils)\n\n")))
          (else
           (display (string->encoded-string (get-result-line shell-command-string)))))))
