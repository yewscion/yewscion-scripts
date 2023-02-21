(define-module (yewscion display-encoded-wifi)
  :use-module (ice-9 ftw)             ; Filesystem stuff
  :use-module (ice-9 rdelim)          ; Delimited I/O
  :use-module (ice-9 popen)           ; Pipes
  :export (get-result-line            ; Interact with environment
           string->encoded-string     ; Encodes Arbitrary Strings
           shell-command-string))     ; Shell Commands to Run

(define* (highest-exponent-needed number base #:optional (exponent 0))
  "Takes a number NUMBER and a numerical base BASE (and optionally a
starting exponent EXPONENT) and returns a number.

Calculates the highest exponent that a specified BASE can be raised to
and still cleanly divide into a NUMBER. The optional EXPONENT argument
is mostly for recursion and referential transparency, but can also be
used to speed up calculation if a known-good exponent is supplied."
  ; This algorithm recurses until it fails to produce an exponent that
  ; divides cleanly, and then returns the exponent preceding the
  ; current one (as the current one will have failed).
  (if (< number (expt base exponent))
      (-  exponent 1)
      (highest-exponent-needed number base (+ 1 exponent))))

(define* (values-by-position number base highest-exponent #:optional (starting-list '()))
  "Takes a decimal number NUMBER, a numerical base BASE, an exponent
HIGHEST-EXPONENT that is assumed to be the highest exponent that BASE
can be raised to and still cleanly divide into NUMBER (and optionally
a prepopulated list STARTING-LIST), and returns a list of integers
representing the value at each rank of the NUMBER in the BASE."
  (cond
   ; If we have a negative exponent, we are done, so return the list.
   ((< highest-exponent 0) starting-list)
   ; If we have 0 as our exponent, we don't need to manipulate the
   ; base.
   ((= highest-exponent 0) (cons number (values-by-position number base (- highest-exponent 1))))
   ; Otherwise, calculate the place value base on the exponent, create
   ; the value at that position, and recurse with an exponent one
   ; lower than the current one. This is probably where we could
   ; refactor.
   (else (let* ((place (expt base highest-exponent))
                     (delta (truncate (/ number place))))
                (cons delta (values-by-position (- number (* place delta)) base (- highest-exponent 1)))))))

(define character-set '(#\x25A0  ; This default character set is
                                 ; actually just the unicode block for
                                 ; Geometric Shapes. So long as You
                                 ; specify a list of characters, You
                                 ; can easily substitute any arbitrary
                                 ; list of characters in the below
                                 ; formulae.
                        #\x25A1
                        #\x25A2
                        #\x25A3
                        #\x25A4
                        #\x25A5
                        #\x25A6
                        #\x25A7
                        #\x25A8
                        #\x25A9
                        #\x25AA
                        #\x25AB
                        #\x25AC
                        #\x25AD
                        #\x25AE
                        #\x25AF
                        #\x25B0
                        #\x25B1
                        #\x25B2
                        #\x25B3
                        #\x25B4
                        #\x25B5
                        #\x25B6
                        #\x25B7
                        #\x25B8
                        #\x25B9
                        #\x25BA
                        #\x25BB
                        #\x25BC
                        #\x25BD
                        #\x25BE
                        #\x25BF
                        #\x25C0
                        #\x25C1
                        #\x25C2
                        #\x25C3
                        #\x25C4
                        #\x25C5
                        #\x25C6
                        #\x25C7
                        #\x25C8
                        #\x25C9
                        #\x25CA
                        #\x25CB
                        #\x25CC
                        #\x25CD
                        #\x25CE
                        #\x25CF
                        #\x25D0
                        #\x25D1
                        #\x25D2
                        #\x25D3
                        #\x25D4
                        #\x25D5
                        #\x25D6
                        #\x25D7
                        #\x25D8
                        #\x25D9
                        #\x25DA
                        #\x25DB
                        #\x25DC
                        #\x25DD
                        #\x25DE
                        #\x25DF
                        #\x25E0
                        #\x25E1
                        #\x25E2
                        #\x25E3
                        #\x25E4
                        #\x25E5
                        #\x25E6
                        #\x25E7
                        #\x25E8
                        #\x25E9
                        #\x25EA
                        #\x25EB
                        #\x25EC
                        #\x25ED
                        #\x25EE
                        #\x25EF
                        #\x25F0
                        #\x25F1
                        #\x25F2
                        #\x25F3
                        #\x25F4
                        #\x25F5
                        #\x25F6
                        #\x25F7
                        #\x25F8
                        #\x25F9
                        #\x25FA
                        #\x25FB
                        #\x25FC
                        #\x25FD
                        #\x25FE
                        #\x25FF ))

(define (encode-digit number character-set)
  "Takes an integer NUMBER and a list of characters CHARACTER-SET, and
returns the character at the NUMBER position in that set. If NUMBER is
larger than the length of the list, returns NIL."
  (let ((array (list->array 1 character-set))) ; Convert the list to
                                               ; an array, to support
                                               ; large sets.
    (unless (> number (- (array-length array) 1)) ; Filter out numbers
                                                  ; outside of our
                                                  ; set.
      (array-ref array number))))

(define* (encode-digit-list list #:optional (character-set character-set))
  "Takes a list of integers LIST (and optionally a list of characters
CHARACTER-SET, and returns a list of characters taken from the set by
using the integers in LIST as indices to CHARACTER-SET."
  (map
   (lambda (x)
     (encode-digit x character-set))
   list))

(define* (value->list value #:optional (starting-base 16) (character-set character-set))
  "Takes a string which represents a number VALUE (and optionally a
base STARTING-BASE (defaults to hexadecimal) and a character set
CHARACTER-SET (defaults to included character-set)) and returns a list
of integers representing the index in the character set needed for a
specific rank."
  (let* ((number (string->number value starting-base))
                                        ; Decode the string into a
                                        ; decimal number.
         (ending-base (- (length character-set) 1))
                                        ; The base is the length of
                                        ; the character set minus 1,
                                        ; due to zero indexing.
         (exponent (highest-exponent-needed number ending-base)))
                                        ; Start with the highest
                                        ; exponent that lets the base
                                        ; cleanly divide into the
                                        ; number.
    (values-by-position number ending-base exponent)))

(define* (combine-sum start-list #:optional (character-set character-set))
  "Takes a list of integers START LIST (and optionally a CHARACTER-SET), and
returns a list of integers sums each pair of integers obtained by summing each
pair of integers in START-LIST and dividing the result by the length of
CHARACTER-SET minus 1."
  (let ((denominator (- (length character-set) 1)) ; For Zero Indexing, we need
                                                   ; to subtract 1.
        (list-length (length start-list)))         
  (cond ((= list-length 1)
         start-list)
        ((= list-length 2)
         (list (modulo
                (+ (car start-list) (cadr start-list))
                denominator)))
        (else
         (cons (modulo
                (+ (car start-list) (cadr start-list))
                denominator)
               (combine-sum (cddr start-list)))))))

; This is the list of commands run on the shell to get the original
; hex value.
(define shell-command-string
  (string-append
   "nmcli connection show --active | " ; Get the active connections.
   "grep wifi | "                      ; Only keep the wifi.
   "sed 's/  .*-.*-.*//' | "           ; Only keep the essid.
   "sha1sum | "                        ; Hash it.
   "sed 's/  -//'"))                   ; Remove formatting, leaving                                       ; hex.

(define (get-result-line command)
  "Obtain a value from outside of scheme that will be used as the base
for our encoding by running COMMAND. Only reads the first line of
output."
  (let* ((port (open-input-pipe command))
         (value (read-line port)))
    (close-pipe port)
    value))

(define* (string->encoded-string original-string #:optional (base 16) (character-set character-set))
  "Takes a string which represents a number in some base ORIGINAL-STRING (and
optionally a numerical base for that string BASE and a character set to encode
the string into CHARACTER-SET and returns the encoded string."
  (list->string
   (encode-digit-list
    (combine-sum
     (combine-sum
      (value->list original-string base character-set)
      character-set)
     character-set)
    character-set)))
