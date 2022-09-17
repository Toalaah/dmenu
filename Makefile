# dmenu - dynamic menu
# See LICENSE file for copyright and license details.

include src/config.mk

SRC = src/drw.c src/dmenu.c src/stest.c src/util.c
OBJ = $(SRC:.c=.o)

all: options dmenu stest

options:
	@echo dmenu build options:
	@echo "CFLAGS   = $(CFLAGS)"
	@echo "LDFLAGS  = $(LDFLAGS)"
	@echo "CC       = $(CC)"

src/.c.o:
	$(CC) -c $(CFLAGS) $<

config.h:
	cp config.def.h $@

$(OBJ): src/arg.h src/config.h src/config.mk src/drw.h

dmenu: src/dmenu.o src/drw.o src/util.o
	$(CC) -o $@ src/dmenu.o src/drw.o src/util.o $(LDFLAGS)

stest: src/stest.o
	$(CC) -o $@ src/stest.o $(LDFLAGS)

clean:
	rm -f dmenu stest $(OBJ)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dmenu scripts/dmenu_path scripts/dmenu_run stest $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_path
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu_run
	chmod 755 $(DESTDIR)$(PREFIX)/bin/stest

ansible-diff:
	@[[ $$(sha256sum $$(which dmenu) ./dmenu | awk '{ print $$1 }' | uniq | wc -l) -ne 1 ]] && echo ANSIBLE_CHANGED_TRUE; true

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/dmenu\
		$(DESTDIR)$(PREFIX)/bin/dmenu_path\
		$(DESTDIR)$(PREFIX)/bin/dmenu_run\
		$(DESTDIR)$(PREFIX)/bin/stest\
		$(DESTDIR)$(MANPREFIX)/man1/dmenu.1\
		$(DESTDIR)$(MANPREFIX)/man1/stest.1

.PHONY: all options clean dist install uninstall
