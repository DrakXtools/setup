subdir = cs et eu fr it nl uk
mandir = /usr/share/man

all: 

clean:

install:
	@for dir in $(subdir); do \
		install -d $(DESTDIR)$(mandir)/$$dir/man8; \
		install -m 644 $$dir/*.8 $(DESTDIR)$(mandir)/$$dir/man8; \
	done

