mandir = /usr/share/man

all: run-parts

run-parts: run-parts.c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f run-parts *.o *~

install: all
	install -D -m 644 run-parts.8 $(DESTDIR)/$(mandir)/man8/run-parts.8
	install -D -m 755 run-parts $(DESTDIR)/usr/bin/run-parts
