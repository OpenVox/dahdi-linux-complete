#
# Makefile for DAHDI Linux kernel modules and tools
#
# Copyright (C) 2008 Digium, Inc.
#
#

all:
	$(MAKE) -C linux all
	(cd tools && autoreconf -i && [ -f config.status ] || (aclocal && autoconf && automake --add-missing && ./configure --with-dahdi=../linux) \
	|| ./configure --with-dahdi=../linux )
	$(MAKE) -C tools all

clean:
	$(MAKE) -C linux clean
	$(MAKE) -C tools clean

distclean: clean
	$(MAKE) -C linux distclean
	$(MAKE) -C tools distclean

dist-clean: distclean

install: all
	$(MAKE) -C linux install
	$(MAKE) -C tools install

install-config: install
	$(MAKE) -C tools install-config
	[ -x /usr/sbin/dahdi_genconf ] && dahdi_genconf modules

.PHONY: all clean distclean dist-clean install config
