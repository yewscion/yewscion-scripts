include guile.am

SOURCES =				\
push-all-git-repos.scm                  \
pull-projects.scm

EXTRA_DIST =				\
README.md				\
bootstrap				\
pre-inst-env.in				\
bin/pagr.scm				\
bin/adlmidi-wrapper.scm			\
bin/ssh-wrapper.scm                     \
bin/pull-projects.scm                   \
pull-projects.scm

bin_SCRIPTS =				\
pagr					\
adlmidi-wrapper				\
ssh-wrapper                             \
pull-projects

pagr: bin/pagr.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' < $(srcdir)/bin/pagr.scm > ./pagr
	chmod +x pagr
adlmidi-wrapper: bin/adlmidi-wrapper.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' < $(srcdir)/bin/adlmidi-wrapper.scm > ./adlmidi-wrapper
	chmod +x adlmidi-wrapper
ssh-wrapper: bin/ssh-wrapper.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' < $(srcdir)/bin/ssh-wrapper.scm > ./ssh-wrapper
	chmod +x ssh-wrapper
pull-projects: bin/pull-projects.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' < $(srcdir)/bin/pull-projects.scm > ./pull-projects
	chmod +x pull-projects
push-all-git-repos.scm:
	cat < $(srcdir)/share/guile/push-all-git-repos.scm > push-all-git-repos.scm
pull-projects.scm:
	cat < $(srcdir)/share/guile/pull-projects.scm > pull-projects.scm

clean-local:
	rm -rfv push-all-git-repos.scm pagr adlmidi-wrapper ssh-wrapper pull-projects *~
