include guile.am

SOURCES =				\
push-all-git-repos.scm

EXTRA_DIST =				\
README.md				\
bootstrap				\
pre-inst-env.in				\
bin/pagr.scm				\
bin/adlmidi-wrapper.scm

bin_SCRIPTS =				\
pagr					\
adlmidi-wrapper

pagr: bin/pagr.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' < $(srcdir)/bin/pagr.scm > ./pagr
	chmod +x pagr
adlmidi-wrapper: bin/adlmidi-wrapper.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' < $(srcdir)/bin/adlmidi-wrapper.scm > ./adlmidi-wrapper
	chmod +x adlmidi-wrapper
push-all-git-repos.scm:
	cat < $(srcdir)/share/guile/push-all-git-repos.scm > push-all-git-repos.scm

clean-local:
	rm -rfv push-all-git-repos.scm pagr adlmidi-wrapper *~
