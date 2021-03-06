PACKAGE = setup
VERSION = 2.8.9
GITPATH = git@github.com:DrakXtools/setup.git

LIST =  csh.cshrc csh.login ethertypes host.conf hosts.allow hosts.deny inputrc \
	motd printcap protocols services shells profile \
	filesystems fstab resolv.conf hosts

FILES = $(LIST) Makefile NEWS

all: 


check:
	@echo Sanity checking selected files....
	sh -n profile
	tcsh -f csh.cshrc
	tcsh -f csh.login
	./serviceslint ./services

clean:
	rm -f *~ \#*\#

install:
	install -d -m 755 $(DESTDIR)/etc/
	install -d -m 755 $(DESTDIR)/etc/profile.d
	install -d -m 755 $(DESTDIR)/var/log/
	for i in $(LIST); do \
		cp -avf $$i $(DESTDIR)/etc/$$i; \
	done
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
