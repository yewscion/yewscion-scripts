(define-module (pagr)
  :use-module (ice-9 ftw)
  :export (push-all-git-repos))

(define (directory->list directory)
  "Returns a list containing the names of each file in the given directory."
  (map
   (lambda (x)
     (string-append directory "/" x))
   (map
    car
    (cddr (file-system-tree directory)))))
(define (repository? directory)
  "Tests to see if the given directory is a git repository."
  (member (string-append directory "/.git") (directory->list directory)))
(define (find-git-repos directory)
  "Returns a list of all git repositories currently inside of DIRECTORY."
  (filter repository? (directory->list directory)))
(define (push-git-repo repository remote)
  "Calls system's git to push REPOSITORY to REMOTE."
  (narrate-directory-push repository)
  (display (string-append "git -C " repository " push " remote " trunk\n"))
  (system (string-append "git -C " repository " push " remote " trunk")))

(define (greet-the-user)
  "Display a greeting to the user."
  (display "Beginning push of all git repos in ~/Documents now!\n"))
(define (narrate-directory-push directory)
  "Tell the user we are pushing the given DIRECTORY"
  (display (string-append "Pushing " directory " now!\n")))
(define (farewell-the-user)
  "Bid the user farewell."
  (display "All directories pushed!\n"))

(define (push-all-git-repos directory remote)
  "Pushes all Git Repositories inside of DIRECTORY"
  (greet-the-user)
  (map
   (lambda (repo)
     (push-git-repo repo remote))
   (find-git-repos directory))
  (farewell-the-user))
