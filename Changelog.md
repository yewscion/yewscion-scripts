     # Changelog
     All notable changes to this project will be documented in this file.

     The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
     and this projectadheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

     ## [Unreleased]
     ### Added
        - `adlmidi-wrapper` - allows standard calling of program with
          options, so it can easily work with EMMS.
        - `push-all-git-repos` - a scheme library to push all git
          repositories in a specific directory. Has a wrapper in `pagr.scm`
        - Standard Project Files (README.md, Changelog.md, AUTHORS, LICENSE, .gitignore)
        - Autotools setup
     ### Changed
        - Rewrote `pagr.sh` in GNU Guile Scheme as `pagr.scm`
     ### Removed
        - Obsolete `pagr.sh` wrapper script for `push-all-git-repos`

     [Unreleased]: https://git.sr.ht/~yewscion/yewscion-scripts/log