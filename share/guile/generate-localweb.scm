(define-module (generate-localweb)
  :use-module (ice-9 ftw)
  :use-module (cdr255 userlib)
  :export (generate-localweb
           generate-command-string))

(define +default-variables+
  `((directory
     ,(string-append
       (getenv "HOME")
       "/LocalWeb"))
    (mirrorlist-directory
     ,(string-append
       (getenv "HOME")
       "/LocalWeb"))
    (mirrorlist-file
     "mirrorlist.txt")
    (list-of-numbers
     (104
      3600
      2
      1
      7
      0
      10000000000000))
    (language-preferences
     "\"en, *\"")
    (user-agent-string
     ,(string-append
       "\"Mozilla/5.0 (X11; Linux x86_64; rv:83.0) "
       "Gecko/20100101 Firefox/83.0\""))
    (html-footer
     "\"<!-- Mirrored [from host %s [file %s [at %s]]] -->\"")
    (mime-options
     "asp=text/html,php3=text/html,php=text/html,cgi=image/gif")
    (singleton-options
     ("-B"
      "--update"
      "-C"
      "-%x"
      "-%s"
      "-z"
      "-%I"
      "-I"
      "-a"))
    (filters
     ("\"-$site*Special:*\""
      "\"-$site*?title=Special:*\""
      "\"+$site*Special:Recentchanges\""
      "\"-$site*User:*\""
      "\"-$site*Talk_User:*\""
      "\"-$site*MediaWiki:*\""
      "\"-$site*Talk_MediaWiki:*\""
      "\"-$site*Help:*\""
      "\"-$site*Talk_Help:*\""
      "\"-$site*Project:*\""
      "\"-$site*Talk_Project:*\""
      "\"+*.css\""
      "\"-$site*?title=*&oldid=*\""
      "\"-$site*?title=*&action=edit*\""
      "\"-$site*?title=*&curid=*\""
      "\"+$site*?title=*&action=history\""
      "\"-$site*?title=*&action=history&*\""
      "\"-$site*?title=*&curid=*&action=history*\""
      "\"-$site*?title=*&limit=*&action=history\""))))
(define (default-values symbol)
  (car (assoc-ref +default-variables+ symbol)))
(define command-name "httrack")
(define (get-mirrorlist directory file)
  (remove-empty-strings (string-split
   (get-file-as-string (string-append directory "/" file))
   #\newline)))
(define (generate-mirrorlist-option mirrorlist-directory filename)
  (string-append "-%L "
                 mirrorlist-directory
                 "/"
                 filename))
(define (generate-output-directory-option directory)
  (string-append "-O "
                 directory))
(define (generate-language-preferences language-preferences)
  (string-append "-%l "
                 language-preferences))
(define (generate-user-agent-string user-agent-string)
  (string-append "-F "
                 user-agent-string))
(define (generate-html-footer html-footer)
  (string-append "-%F "
                 html-footer))
(define (generate-numeric-options list-of-numbers)
  (string-append "-N"
                 (number->string (car list-of-numbers))
                 " -E"
                 (number->string (cadr list-of-numbers))
                 " -u"
                 (number->string (caddr list-of-numbers))
                 " -s"
                 (number->string (cadddr list-of-numbers))
                 " -p"
                 (number->string (cadr (cdddr list-of-numbers)))
                 " -K"
                 (number->string (caddr (cdddr list-of-numbers)))
                 " -#L"
                 (number->string (cadddr (cdddr list-of-numbers)))))
(define (generate-mime-options mime-options)
  (string-append "-%A "
                 mime-options))
(define* (generate-filters #:key
                          (filters
                           (default-values
                             'filters))
                          (mirrorlist-directory
                           (default-values
                             'mirrorlist-directory))
                          (mirrorlist-file
                           (default-values
                             'mirrorlist-file)))
  (let ((sites (get-mirrorlist mirrorlist-directory mirrorlist-file)))
    (string-join (iteratively-replace-regexp "\\$site" filters sites)
               " "
               'infix)))
(define (generate-singleton-options singleton-options)
  (string-join singleton-options
               " "
               'infix))
(define* (generate-value-options #:key
                                 (language-preferences
                                  (default-values
                                    'language-preferences))
                                 (user-agent-string
                                  (default-values
                                    'user-agent-string))
                                 (html-footer
                                  (default-values
                                    'html-footer))
                                 (mime-options
                                  (default-values
                                    'mime-options)))
  (string-join (list
                (generate-language-preferences language-preferences)
                (generate-user-agent-string user-agent-string)
                (generate-html-footer html-footer)
                (generate-mime-options mime-options))
               " "
               'infix))
(define* (generate-mirror-options #:key
                                  (directory (default-values
                                               'directory))
                                  (mirrorlist-directory
                                   (default-values
                                     'mirrorlist-directory))
                                  (mirrorlist-file (default-values
                                                     'mirrorlist-file)))
  (string-join (list
                (generate-mirrorlist-option mirrorlist-directory
                                            mirrorlist-file)
                (generate-output-directory-option directory))
               " "
               'infix))
(define*  (generate-simple-options #:key
                                   (singleton-options
                                    (default-values
                                      'singleton-options))
                                   (list-of-numbers (default-values
                                                      'list-of-numbers)))
  (string-join (list
                (generate-singleton-options
                 singleton-options)
                (generate-numeric-options
                 list-of-numbers))
               " "
               'infix))
(define (string->keyword original-string)
  (symbol->keyword
   (string->symbol
    original-string)))
(define (keys-if-locally-bound alist-of-keys)
  (cond ((= (length alist-of-keys) 0)
         '())
        (else
         (append '()
                 (key-if-locally-bound
                  (caar alist-of-keys)
                  (cadar alist-of-keys))
                 (keys-if-locally-bound (cdr alist-of-keys))))))
(define (key-if-locally-bound symbol keyword-string)
  (if symbol
      (list (string->keyword keyword-string)
            symbol)
      '()))
(define (set-local-keys procedure list-of-strings)
  (apply procedure
         (append '()
                 (keys-if-locally-bound list-of-strings))))
(define* (generate-command-string #:key
                                  language-preferences
                                  user-agent-string
                                  html-footer
                                  mime-options
                                  directory
                                  mirrorlist-directory
                                  mirrorlist-file
                                  singleton-options
                                  list-of-numbers
                                  (filters
                                   (default-values
                                     'filters)))
  (string-join (list command-name
                     (set-local-keys generate-simple-options
                                     `((,singleton-options
                                        "singleton-options")
                                       (,list-of-numbers
                                        "list-of-numbers")))
                     (set-local-keys generate-value-options
                                     `((,language-preferences
                                        "language-preferences")
                                       (,user-agent-string
                                        "user-agent-string")
                                       (,html-footer
                                        "html-footer")
                                       (,mime-options
                                        "mime-options")))
                     (set-local-keys generate-mirror-options
                                     `((,directory
                                        "directory")
                                       (,mirrorlist-directory
                                        "mirrorlist-directory")
                                       (,mirrorlist-file
                                        "mirrorlist-file")))
                     (set-local-keys generate-filters
                                     `((,filters
                                        "filters")
                                       (,mirrorlist-directory
                                        "mirrorlist-directory")
                                       (,mirrorlist-file
                                        "mirrorlist-file"))))
               " "
               'infix))
(define (generate-localweb)
  (system (generate-command-string)))
