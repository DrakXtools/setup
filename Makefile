PACKAGE = setup
VERSION = 2.8.1
GITPATH = git@abf.rosalinux.ru:software/setup.git

LIST =  csh.cshrc csh.login host.conf hosts.allow hosts.deny inputrc \
	motd printcap protocols securetty services shells profile \
	filesystems fstab resolv.conf hosts

FILES = $(LIST) Makefile NEWS

all: 

clean:
	rm -f *~ \#*\#

install:
	install -d -m 755 $(DESTDIR)/etc/
	install -d -m 755 $(DESTDIR)/etc/profile.d
	install -d -m 755 $(DESTDIR)/var/log/
	for i in $(LIST); do \
		cp -avf $$i $(DESTDIR)/etc/$$i; \
	done
	chmod 0600 $(DESTDIR)/etc/securetty
	touch $(DESTDIR)/var/log/lastlog
	install -m644 group -D $(DESTDIR)/etc/group
	sed -e 's/:[0-9]\+:/::/g' group > $(DESTDIR)/etc/gshadow
	install -m644 passwd -D $(DESTDIR)/etc/passwd
	sed -e "s/:.*/:*:`expr $(shell date +%s) / 86400`:0:99999:7:::/" passwd > $(DESTDIR)/etc/shadow
	sed -i -e 's/^\([^:]\+\):[^:]*:/\1:x:/' $(DESTDIR)/etc/{passwd,group}

# rules to build a public distribution

dist: tar gittag

tar:
	git archive --format=tar --prefix=$(PACKAGE)-$(VERSION)/ HEAD | xz -vf > $(PACKAGE)-$(VERSION).tar.xz

gittag:
	git tag 'v$(VERSION)'
