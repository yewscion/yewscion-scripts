# Template Variables: yewscion-scripts
################################################################################

# Set Up Guile Variables

GUILE_WARNINGS = -Wunbound-variable -Warity-mismatch -Wformat

## Directory for Uncompiled Guile Modules
moddir=$(prefix)/share/guile/site/$(GUILE_EFFECTIVE_VERSION)

## Directory for Compiled Guile Modules
godir=$(libdir)/guile/$(GUILE_EFFECTIVE_VERSION)/site-ccache

## Same as above, but for transient Compiled Guile Modules
ccachedir=$(libdir)/guile/$(GUILE_EFFECTIVE_VERSION)/site-ccache

## Handle substitution of fully-expanded Guile Autoconf variables.
do_subst = $(SED)					\
  -e 's,[@]GUILE[@],$(GUILE),g'				\
  -e 's,[@]guilemoduledir[@],$(guilemoduledir),g'	\
  -e 's,[@]guileobjectdir[@],$(guileobjectdir),g'	\
  -e 's,[@]localedir[@],$(localedir),g'

## Handle Special Build Reqs
SUFFIXES = .scm .go
.scm.go:
	$(AM_V_GEN)$(top_builddir)/pre-inst-env $(GUILE_TOOLS) \
	compile $(GUILE_WARNINGS) -o "$@" "$<"

################################################################################

# Set Up Other Variables

## Enable local m4 cache
ACLOCAL_AMFLAGS = -I m4

## Documentation Compilation

info_TEXINFOS = doc/yewscion-scripts.texi

## Extra Files for Distribution
EXTRA_DIST =	LICENSE \
		COPYING \
		NEWS \
		AUTHORS \
		README.org \
		README.md \
		Changelog.org \
		ChangeLog \
		COPYING \
		guix.scm \
		pre-inst-env.in \
		bootstrap \
		tests/maintests.scm \
		build-aux/test-driver.scm \
		doc/version.texi.in \
		doc/fdl-1.3.texi \
		doc/procedure-types.texi \
		m4/tar-edited.m4 \
		bin/adlmidi-wrapper.in \
		bin/pull-projects.in \
		bin/display-encoded-wifi.in \
		bin/generate-localweb.in \
		bin/run-backups.in \
		bin/,google-messages.in \
		bin/,scholar-social.in \
		bin/,update-all-remote-systems.in \
		bin/,daily-update-guix.in \
		bin/update-all-remote-systems.in

## Cleaning Up

### Clean Up Compiled Guile Modules
clean-go:
	-$(RM) $(GOBJECTS)
.PHONY: clean-go

### Filelist for make clean
CLEANFILES =					\
  $(GOBJECTS)					\
  $(TESTS:tests/%.scm=%.log)				
################################################################################
# Define Inputs

# ## Define Guile files
GUILESOURCES = 	$(builddir)/yewscion/pull-projects.scm \
		$(builddir)/yewscion/generate-localweb.scm \
		$(builddir)/yewscion/display-encoded-wifi.scm \
		$(builddir)/yewscion/update-all-remote-systems.scm \
		$(builddir)/yewscion/run-backups.scm


## Don't Distribute, Don't Install
nodist_noinst_SCRIPTS = pre-inst-env
################################################################################

# Define Outputs

## Scripts that are not compiled
bin_SCRIPTS = 	$(builddir)/bin/adlmidi-wrapper	\
		$(builddir)/bin/pull-projects \
		$(builddir)/bin/display-encoded-wifi \
		$(builddir)/bin/update-all-remote-systems \
		$(builddir)/bin/generate-localweb \
		$(builddir)/bin/,google-messages \
		$(builddir)/bin/,scholar-social \
		$(builddir)/bin/,update-all-remote-systems \
		$(builddir)/bin/,daily-update-guix \
		$(builddir)/bin/run-backups

## Compiled Guile Modules (foo.go)
GOBJECTS = $(GUILESOURCES:%.scm=%.go)

## These are the actual Modules to Install, with directory structures intact
## (nobase). They are tied to the appropriate dir above.
nobase_mod_DATA = $(GUILESOURCES) $(NOCOMPSOURCES)
nobase_go_DATA = $(GOBJECTS)

## Make sure source files are installed first, so that the mtime of
## installed compiled files is greater than that of installed source
## files.  See
## <http://lists.gnu.org/archive/html/guile-devel/2010-07/msg00125.html>
## for details.
guile_install_go_files = install-nobase_goDATA
$(guile_install_go_files): install-nobase_modDATA

## Symlinks Can Go Here, along with other end-of-install changes
# install-data-hook:
# 	$(LN_S) $(DESTDIR)$(bindir)/realfile $(DESTDIR)$(bindir)/link
# 	chmod +x $(DESTDIR)$(javadir)/yewscion-scripts.jar

## Sources and Extras
EXTRA_DIST += $(JAVASOURCES) $(GUILESOURCES) $(NOCOMP_SOURCES)
################################################################################

# Added Jobs

# Tests
TEST_EXTENSIONS = .scm
TESTS = tests/maintests.scm
AM_TESTS_ENVIRONMENT = abs_top_srcdir="$(abs_top_srcdir)" GUILE_AUTO_COMPILE=0

SCM_LOG_DRIVER =                                 \
   $(top_builddir)/pre-inst-env         \
   $(GUILE) --no-auto-compile -L $(top_srcdir) -e main \
       $(top_srcdir)/build-aux/test-driver.scm

# Tell 'build-aux/test-driver.scm' to display only source file names,
# not indivdual test names.
AM_SCM_LOG_DRIVER_FLAGS = --brief=yes 
