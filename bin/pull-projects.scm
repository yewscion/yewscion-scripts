#!/usr/bin/env -S guile -e main -s
-e main -s
!#
(use-modules (pull-projects))
(define projects '("acreid"
                   "biblio"
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
(define (main args)
  (pull-all-projects "Documents"
                     "git"
                     "cdr255.com"
                     "yewscion"
                     "git"
                     projects))
