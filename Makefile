CC      = cc
CFLAGS  = -std=c99 -Wall -Wextra -Wpedantic -O2
LDFLAGS = -lX11

WM_SRC  = src/kisswm.c src/parser.c
WM_OBJ  = $(WM_SRC:.c=.o)

CTL_SRC = src/kisswmctl.c
CTL_OBJ = $(CTL_SRC:.c=.o)

PREFIX  = /usr/local
BINDIR  = $(PREFIX)/bin

all: kisswm kisswmctl

kisswm: $(WM_OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

kisswmctl: $(CTL_OBJ)
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

src/kisswm.o:    src/kisswm.c    src/parser.h src/config.h src/ipc.h
src/parser.o:    src/parser.c    src/parser.h
src/kisswmctl.o: src/kisswmctl.c src/ipc.h

install: kisswm kisswmctl
	install -Dm755 kisswm    $(DESTDIR)$(BINDIR)/kisswm
	install -Dm755 kisswmctl $(DESTDIR)$(BINDIR)/kisswmctl

uninstall:
	rm -f $(DESTDIR)$(BINDIR)/kisswm
	rm -f $(DESTDIR)$(BINDIR)/kisswmctl

clean:
	rm -f kisswm kisswmctl $(WM_OBJ) $(CTL_OBJ)

.PHONY: all install uninstall clean
