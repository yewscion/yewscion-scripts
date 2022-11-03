(define-module (yewscion initialize-project)
  :use-module (cdr255 userlib)
  :use-module (ice-9 ftw)
  :use-module (srfi srfi-1)
  :use-module (srfi srfi-98)
  :export (initialize-project))
(define* (initialize-project #:key
                              (project-name (dereference-env "PWD"))
                              (template-directory
                               (dereference-env-in-string
                                "HOME"
                                "$HOME/.local/share/empty-repo/"))
                              (verbosity #f))
  (let ((files (scandir template-directory)))
    (when verbosity
      (display (string-append "Project Name: \""
                              project-name
                              "\"\nTemplate Directory: \""
                              template-directory
                              "\"\nFile List: \""
                              (string-join files ",")
                              "\"\n")))
    
    ))

; GOAL: Replicate `cp -LRv --no-preserve=all \
; ~/.local/share/empty-repo/. .;chmod 775 setup-symlinks.sh bootstrap \
; incant.sh;./setup-symlinks.sh`
;;; For verbatim copying: cp -LRv --no-preserve=all ~/.local/share/empty-repo/. .;chmod 775 setup-symlinks.sh bootstrap incant.sh; ./setup-symlinks.sh
