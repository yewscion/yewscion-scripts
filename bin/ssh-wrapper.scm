#!/usr/bin/env -S guile -e main -s
-e main -s
!#
(use-modules (srfi srfi-1))
(define (main args)
  (let ((arguments (cdr args)))
    (cond ((= (length arguments) 0)
           (display (string-append
                     "Usage: ssh-wrapper [ARGUMENTS] HOST\n\n"

                     "The main use for this tool is allowing You to fall\n"
                     "back to the system-installed SSH client when using\n"
                     "a GNU Guix Binary Install.\n\n"
                     "Explanation of Arguments:\n\n"

                     "  HOST:        The host You are trying to SSH into.\n"
                     "  [ARGUMENTS]: An optional list of arguments to ssh\n"
                     "               command.\n\n"

                     "This program is entirely written in GNU Guile Scheme,\n"
                     "and You are welcome to change it how You see fit.\n\n"

                     "Guile Online Help: <https://www.gnu.org/software/guile/>\n"
                     "Local Online Help: 'info guile'\n")))
          ((= (length arguments) 1)
           (system (string-append "/usr/bin/ssh " (car arguments)))
           (system "reset"))
          (else
           (let ((systemcall (string-append "/usr/bin/ssh "
                                            (last arguments)
                                            " "
                                            (reduce
                                             (lambda (x y)
                                               (string-append y " " x))
                                             ""
                                             (drop-right arguments 1)))))
             (display systemcall)
             (newline)
             (system systemcall)
             (system "reset"))))))
