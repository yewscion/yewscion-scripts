dnl Process this file with autoconf
AC_INIT([yewscion-scripts], [0.0.0], [yewscion@gmail.com], [yewscion-scripts-0.0.0.tar.gz], [https://sr.ht/~yewscion/yewscion-scripts/])
AC_CONFIG_SRCDIR([yewscion-scripts.org])
AC_CONFIG_AUX_DIR([build-aux])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])

GUILE_PKG
GUILE_PROGS
if test "x$GUILD" = "x"; then
   AC_MSG_ERROR(['guild' binary not found; please check Your guile installation.])
fi
AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([pre-inst-env], [chmod +x pre-inst-env])
AC_OUTPUT
