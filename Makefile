PACKAGE = setup
VERSION = 2.7.17
SVNPATH = svn+ssh://svn.mandriva.com/svn/soft/$(PACKAGE)

LIST =  csh.cshrc csh.login host.conf hosts.allow hosts.deny inputrc \
	motd printcap protocols securetty services shells profile \
	filesystems fstab resolv.conf hosts

subdir = passgrp utils man

FILES = $(subdir) $(LIST) Makefile NEWS

all: 
	@for dir in $(subdir);do \
		make -C $$dir all ;\
	done

clean:
	@for dir in $(subdir);do \
		make -C $$dir clean ;\
	done
	rm -f *~ \#*\#

install:
	@for dir in $(subdir); do \
		make -C $$dir install DESTDIR=$(DESTDIR);\
	done
	install -d -m 755 $(DESTDIR)/etc/
	install -d -m 755 $(DESTDIR)/var/log/
	for i in $(LIST); do \
		cp -avf $$i $(DESTDIR)/etc/$$i; \
	done
	chmod 0600 $(DESTDIR)/etc/securetty
	echo -n '' > $(DESTDIR)/var/log/lastlog
	echo -n '' > $(DESTDIR)/etc/mtab

# rules to build a local distribution

localdist: cleandist dir localcopy tar

cleandist: clean
	rm -rf $(PACKAGE)-$(VERSION) $(PACKAGE)-$(VERSION).tar.bz2

dir:
	mkdir $(PACKAGE)-$(VERSION)

localcopy:
	tar c --exclude=.svn $(FILES) | tar x -C $(PACKAGE)-$(VERSION)   

tar:
	tar cvjf $(PACKAGE)-$(VERSION).tar.bz2 $(PACKAGE)-$(VERSION)
	rm -rf $(PACKAGE)-$(VERSION)

# rules to build a public distribution

dist: cleandist dir localcopy tar svntag

svntag:
	svn cp -m 'version $(VERSION)' $(SVNPATH)/trunk $(SVNPATH)/tags/v$(VERSION)
