APPNAME       = mpd-spawn-slave
DIST_ROOT     := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
TOOLSDIR      := ${DIST_ROOT}tools

DESTDIR       =
PREFIX        = /usr/local
INSTALL       = /usr/bin/install -D
MSGFMT        = /usr/bin/msgfmt
SED           = /bin/sed
bindir        = $(PREFIX)/bin
libdir        = $(PREFIX)/lib
systemddir    = $(libdir)/systemd
systemduserdir = $(systemddir)/user
sysconfdir    = $(PREFIX)/etc
datarootdir   = ${PREFIX}/share
datadir       = ${datarootdir}
mandir        = ${datarootdir}/man
zsh_compdir   = $(datarootdir)/zsh/site-functions

SHPP	      = shpp
override SHPPFLAGS+= -M${DIST_ROOT}/shpp.local
BUILTIN_SHPP  = ${TOOLSDIR}/shpp
WBUILTIN_SHPP = 0

ifneq ($(WBUILTIN_SHPP),0)
SHPP          = $(BUILTIN_SHPP)
endif
