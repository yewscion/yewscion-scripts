#!/usr/bin/env -S guile -e main -s
-e main -s
!#
(use-modules (srfi srfi-1))
(define (main args)
  (let ((arguments (cdr args)))
    (cond ((= (length arguments) 0)
           (display (string-append
                     "Usage: adlmidi-wrapper [ARGUMENTS] MIDIFILE\n\n"

                     "Explanation of Arguments:\n\n"

                     "  FILE:        The MIDI file You want to play using\n"
                     "               adlmidi.\n"
                     "  [ARGUMENTS]: An optional list of arguments to adlmidi\n"
                     "               itself, which would normally go at the\n"
                     "               end of the command.\n\n"

                     "This program is entirely written in GNU Guile Scheme,\n"
                     "and You are welcome to change it how You see fit.\n\n"

                     "Guile Online Help: <https://www.gnu.org/software/guile/>\n"
                     "Local Online Help: 'info guile'\n")))
          ((= (length arguments) 1)
           (system (string-append "adlmidi " (car arguments)))
           (system "reset"))
          (else
           (let ((systemcall (string-append "adlmidi "
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
