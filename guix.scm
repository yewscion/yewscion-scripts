(use-modules
 ;;; These are my commonly needed modules; remove unneeded ones.
 (guix packages)
 ((guix licenses) #:prefix license:)
 (guix download)
 (guix build-system gnu)
 (gnu packages)
 (gnu packages autotools)
 (gnu packages backup)
 (gnu packages pkg-config)
 (gnu packages ssh)
 (gnu packages rsync)
 (gnu packages ocaml)
 (gnu packages texinfo)
 (gnu packages guile)
 (cdr255 yewscion)
 (guix gexp))

(package
 (name "yewscion-scripts")
 (version "0.2.1")
 (source (local-file (string-append "./"
                                    name
                                    "-"
                                    version
                                    ".tar.bz2")))
 (build-system gnu-build-system)
 (arguments
  `(#:tests? #f
    #:phases
    (modify-phases
     %standard-phases
     ;; This allows the paths for guile and java to be embedded in the scripts
     ;; in bin/
     (add-before
      'patch-usr-bin-file 'remove-script-env-flags
      (lambda* (#:key inputs #:allow-other-keys)
        (substitute*
         (find-files "./bin")
         (("#!/usr/bin/env -S guile \\\\\\\\")
          "#!/usr/bin/env guile \\")
         (("\"java")
          (string-append "\"" (search-input-file inputs "/bin/java"))))))
     ;; Java and Guile programs don't need to be stripped.
     (delete 'strip))))
 (native-inputs (list autoconf automake pkg-config texinfo
                      guile-cdr255))
 (propagated-inputs (list restic
                          openssh
                          rsync
                          unison))
 (inputs (list guile-3.0-latest))
 (synopsis "Utility Scripts from yewscion")
 (description
  (string-append
   "A personal collection of scripts written to aid with system "
   "administration tasks."))
 (home-page "https://git.sr.ht/~yewscion/yewscion-scripts")
 (license license:agpl3))
;; Local Variables:
;; mode: scheme
;; End:
