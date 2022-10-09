include guile.am

SOURCES =				\
pull-projects.scm                       \
display-encoded-wifi.scm                \
generate-localweb.scm

EXTRA_DIST =				\
README.md				\
bootstrap				\
pre-inst-env.in				\
bin/adlmidi-wrapper.scm			\
bin/ssh-wrapper.scm                     \
bin/pull-projects.scm                   \
bin/display-encoded-wifi.scm            \
bin/generate-localweb.scm


bin_SCRIPTS =				\
adlmidi-wrapper				\
ssh-wrapper                             \
pull-projects                           \
display-encoded-wifi                    \
generate-localweb

adlmidi-wrapper: bin/adlmidi-wrapper.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' \
	< $(srcdir)/bin/adlmidi-wrapper.scm > ./adlmidi-wrapper
	chmod +x adlmidi-wrapper
generate-localweb: bin/generate-localweb.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' \
	< $(srcdir)/bin/generate-localweb.scm > ./generate-localweb
	chmod +x generate-localweb
ssh-wrapper: bin/ssh-wrapper.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' \
	< $(srcdir)/bin/ssh-wrapper.scm > ./ssh-wrapper
	chmod +x ssh-wrapper
pull-projects: bin/pull-projects.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' \
	< $(srcdir)/bin/pull-projects.scm > ./pull-projects
	chmod +x pull-projects
display-encoded-wifi: bin/display-encoded-wifi.scm
	sed -e 's,#!\/usr\/bin\/env -S guile -e main -s,\#!$(GUILE) \\,g' \
	< $(srcdir)/bin/display-encoded-wifi.scm > ./display-encoded-wifi
	chmod +x display-encoded-wifi
pull-projects.scm:
	cat < $(srcdir)/share/guile/pull-projects.scm > \
	pull-projects.scm
display-encoded-wifi.scm:
	cat < $(srcdir)/share/guile/display-encoded-wifi.scm > \
	display-encoded-wifi.scm
generate-localweb.scm:
	cat < $(srcdir)/share/guile/generate-localweb.scm > \
	generate-localweb.scm
clean-local:
	rm -rfv push-all-git-repos.scm pagr adlmidi-wrapper \
	ssh-wrapper pull-projects pull-projects.scm config.log \
	config.status pre-inst-env Makefile display-encoded-wifi.scm \
	display-encoded-wifi generate-localweb.scm generate-localweb *~
