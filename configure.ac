dnl Process this file with autoconf
AC_INIT([yewscion-scripts],
        [0.2.1],
        [yewscion@gmail.com],
        [yewscion-scripts],
        [https://sr.ht/~yewscion/yewscion-scripts/])

dnl General Project Variables
AC_SUBST(LICENSE, ["Copyright (C) 2022 Christopher Rodriguez

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>."])
AC_SUBST(PACKAGE_DOCS_COMMAND, [info])

dnl Skip Multiline Variables in Automake per:
dnl https://automake.gnu.narkive.com/99bOFWk4/multiline-variables-and-ac-subst#post2
_AM_SUBST_NOTMAKE([LICENSE])
AC_CONFIG_SRCDIR([README.md])
AC_CONFIG_AUX_DIR([build-aux])

dnl Set Up Automake
AM_INIT_AUTOMAKE([-Wall -Werror -Wportability gnu check-news dist-bzip2
filename-length-max=99 std-options])

dnl Set Up Guile 3.0
GUILE_PKG([3.0])
GUILE_PROGS
if test "x$GUILD" = "x"; then
   AC_MSG_ERROR(['guild' binary not found;
   please check Your guile installation.])
fi
GUILE_SITE_DIR

dnl Installation directories for .scm and .go files.
guilemoduledir="${datarootdir}/guile/site/$GUILE_EFFECTIVE_VERSION"
guileobjectdir="${libdir}/guile/$GUILE_EFFECTIVE_VERSION/site-ccache"
AC_SUBST([guilemoduledir])
AC_SUBST([guileobjectdir])

dnl Finishing Up
AC_PROG_LN_S
AC_PROG_MKDIR_P
AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([pre-inst-env], [chmod +x pre-inst-env])
AC_CONFIG_FILES([bin/adlmidi-wrapper],[chmod +x bin/adlmidi-wrapper])
AC_CONFIG_FILES([bin/chromium-wrapper],[chmod +x bin/chromium-wrapper])
AC_CONFIG_FILES([bin/display-encoded-wifi],[chmod +x bin/display-encoded-wifi])
AC_CONFIG_FILES([bin/pull-projects],[chmod +x bin/pull-projects])
AC_CONFIG_FILES([bin/update-all-remote-systems],[chmod +x bin/update-all-remote-systems])
AC_CONFIG_FILES([bin/generate-localweb],[chmod +x bin/generate-localweb])
AC_CONFIG_FILES([bin/run-backups],[chmod +x bin/run-backups])
AC_CONFIG_FILES([bin/,google-messages],[chmod +x bin/,google-messages])
AC_CONFIG_FILES([bin/,amazon-chime],[chmod +x bin/,amazon-chime])
AC_CONFIG_FILES([bin/,emacsclient],[chmod +x bin/,emacsclient])
AC_CONFIG_FILES([bin/,scholar-social],[chmod +x bin/,scholar-social])
AC_CONFIG_FILES([bin/,daily-update-guix],[chmod +x bin/,daily-update-guix])
AC_CONFIG_FILES([bin/,update-all-remote-systems],[chmod +x bin/,update-all-remote-systems])
AC_CONFIG_FILES([bin/sync-directory],[chmod +x bin/sync-directory])
AC_CONFIG_FILES([bin/get-bat0-percent],[chmod +x bin/get-bat0-percent])
AC_CONFIG_FILES([bin/battery-warning],[chmod +x bin/battery-warning])
AC_CONFIG_FILES([yewscion/battery.scm])
AC_CONFIG_FILES([yewscion/display-encoded-wifi.scm])
AC_CONFIG_FILES([yewscion/generate-localweb.scm])
AC_CONFIG_FILES([yewscion/initialize-project.scm])
AC_CONFIG_FILES([yewscion/run-backups.scm])
AC_CONFIG_FILES([yewscion/pull-projects.scm])
AC_CONFIG_FILES([yewscion/update-all-remote-systems.scm])
AC_CONFIG_FILES([doc/version.texi])
AC_OUTPUT
