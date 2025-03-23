PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib/bdo-cli

.PHONY: all install uninstall

all:
	@echo "Available commands:"
	@echo "  make install   - Install bdo-cli"
	@echo "  make uninstall - Uninstall bdo-cli"

install:
	@echo "Installing bdo-cli to $(BINDIR)..."
	install -d $(BINDIR)
	install -d $(LIBDIR)/scripts
	install -m 755 bin/bdo-cli $(BINDIR)/bdo
	install -m 755 scripts/* $(LIBDIR)/scripts/
	@echo "Installation complete. Run 'bdo help' to get started."

uninstall:
	@echo "Uninstalling bdo-cli..."
	rm -f $(BINDIR)/bdo
	rm -rf $(LIBDIR)
	@echo "Uninstallation complete." 