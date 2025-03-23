# Default PREFIX is /usr/local, but bpkg may override this
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib/bdo-cli

.PHONY: all install

all:
	@echo "Available commands:"
	@echo "  make install   - Install bdo-cli"

install:
	@echo "Installing bdo-cli to $(BINDIR)..."
	install -d $(BINDIR)
	install -d $(LIBDIR)/scripts
	install -m 755 bin/bdo-cli $(BINDIR)/bdo
	install -m 755 scripts/* $(LIBDIR)/scripts/
	@echo "Installation complete. Run 'bdo help' to get started." 