include guile.am

SOURCES =				 \
push-all-git-repos.scm

EXTRA_DIST =					\
README.md				\
bootstrap				\
pre-inst-env.in				\
bin/pagr.scm

bin_SCRIPTS = pagr

pagr: bin/pagr.scm
	sed -e 's,#!\/usr\/bin\/env -S guile ,\#!$(GUILE) ,g' < bin/pagr.scm > ./pagr
	chmod +x pagr
push-all-git-repos.scm:
	cat < share/guile/push-all-git-repos.scm > push-all-git-repos.scm
