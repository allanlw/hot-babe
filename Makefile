PREFIX := /usr/local

# optimization cflags
CFLAGS += -DPREFIX=\"$(PREFIX)\"
CFLAGS += $(shell pkg-config gdk-3.0 --cflags) -std=gnu99
CFLAGS += -Wno-unused-parameter -Wno-missing-field-initializers 
CFLAGS += -Wno-sign-compare

OBJS = src/hot-babe.o src/loader.o src/stats.o src/config.o
CC = gcc
LIBS = $(shell pkg-config gdk-3.0 --libs) -lm

DOC = ChangeLog NEWS LICENSE CONTRIBUTORS copyright config.example

all: hot-babe

hot-babe: $(OBJS)
	$(CC) $(LDFLAGS) -o hot-babe $(OBJS) $(LIBS)

clean:
	rm -f hot-babe src/*.o

install:
	install -d $(DESTDIR)$(PREFIX)/bin
	install -m 0755 hot-babe $(DESTDIR)$(PREFIX)/bin
	install -d $(DESTDIR)$(PREFIX)/share/hot-babe/hb01
	install -m 0644 hb01/* $(DESTDIR)$(PREFIX)/share/hot-babe/hb01
	install -d $(DESTDIR)$(PREFIX)/share/doc/hot-babe
	install -m 0644 $(DOC) $(DESTDIR)$(PREFIX)/share/doc/hot-babe
	install -d $(DESTDIR)$(PREFIX)/share/man/man1
	install -m 0644 hot-babe.1 $(DESTDIR)$(PREFIX)/share/man/man1
	install -d $(DESTDIR)$(PREFIX)/share/pixmaps
	install -m 0644 hot-babe.xpm $(DESTDIR)$(PREFIX)/share/pixmaps

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/hot-babe
	rm -rf $(DESTDIR)$(PREFIX)/share/hot-babe
	rm -rf $(DESTDIR)$(PREFIX)/share/doc/hot-babe
	rm -f $(DESTDIR)$(PREFIX)/share/man/man1/hot-babe.1
	rm -f $(DESTDIR)$(PREFIX)/share/pixmaps/hot-babe.xpm
