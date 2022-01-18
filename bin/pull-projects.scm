#!/usr/bin/env -S guile -e main -s
-e main -s
!#
(define-module (pull-all-projects)
  :use-module (ice-9 ftw)
  :use-module (srfi srfi-1)
  :use-module (srfi srfi-98)
  :export (pull-all-projects))
(define projects '("acreid"
                   "ccna"
                   "cd2b"
                   "cdr255-website"
                   "clhumour"
                   "clojure-brave-true"
                   "cmsc-mode"
                   "cm-step-compiler"
                   "dotfiles"
                   "gitjournal"
                   "grokking-algorithms"
                   "grokking-simplicity"
                   "guix-home"
                   "land-of-lisp"
                   "org"
                   "org-roam"
                   "password-store"
                   "provision-zq630"
                   "self-sovereign-identity"
                   "sicp"
                   "the-programmers-brain"
                   "wiki-templates"
                   "yewscion-blog"
                   "yewscion-guix-channel"
                   "yewscion-scripts"
                   "yewscion-website"))
(define (greet-the-user host directory)
  (display (string-append "Pulling all projects from "
                          host
                          " into "
                          directory
                          " for You, now.\n\n")))
(define (farewell-the-user host directory)
  (display (string-append "Pulled all projects from "
                          host
                          " into "
                          directory
                          ".\n\n")))
(define (format-url gituser host repouser repo suffix)
  (string-append gituser "@" host ":" repouser "/" repo "." suffix))
(define (format-projects-for-server host user projects)
  (map
   (lambda (repo)
     (format-url "git" host user repo "git"))
   projects))
(define (narrate-project-pull project)
  (display (string-append "\n--\n\nPulling down the '" project "' project…\n")))
(define (format-git-clone directory repo)
  (string-append "git -C " directory " clone " repo))
(define (clone-git-repo directory repo)
  (let ((command (format-git-clone directory repo)))
    (system (string-append command "\n"))))
(define (safe-clone-repo directory gituser host repouser repo suffix)
  (let ((clone-url (format-url gituser host repouser repo suffix))
        (clone-dir (canonicalize-path directory)))
    (if (file-exists? (string-append clone-dir "/" repo))
        (skip-repo-exists repo directory)
        (clone-git-repo clone-dir clone-url))))
(define (skip-repo-exists repo clone-dir)
  (display (string-append
            "Warning: Skipping '"
            repo
            "' as there's already a file\nnamed '"
            repo
            "' inside of '"
            clone-dir
            "'.\n")))
(define (pull-all-projects directory gituser host repouser suffix projects)
  (let* ((home-dir (get-environment-variable "HOME"))
         (dest-dir (string-append home-dir "/" directory)))
    (greet-the-user host dest-dir)
    (map
     (lambda (repo)
       (narrate-project-pull repo)
       (safe-clone-repo dest-dir gituser host repouser repo suffix))
     projects)
    (farewell-the-user host dest-dir)))

(pull-all-projects "Documents" "git" "cdr255.com" "yewscion" "git" projects)
