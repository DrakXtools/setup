PACKAGE = setup
VERSION = 2.8.0
SVNPATH = git@abf.rosalinux.ru:moondrake/setup.git

LIST =  csh.cshrc csh.login host.conf hosts.allow hosts.deny inputrc \
	motd printcap protocols securetty services shells profile \
	filesystems fstab resolv.conf hosts

FILES = $(LIST) Makefile NEWS

all: 

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
	touch $(DESTDIR)/var/log/lastlog
	install -m644 group -D $(DESTDIR)/etc/group
	install -m644 passwd -D $(DESTDIR)/etc/passwd

# rules to build a public distribution

dist: tar gittag

tar:
	git archive --format=tar --prefix=$(PACKAGE)-$(VERSION)/ HEAD | xz -vf > $(PACKAGE)-$(VERSION).tar.xz

gittag:
	git tag 'v$(VERSION)'
