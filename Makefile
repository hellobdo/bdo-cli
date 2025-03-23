PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib/bdo-cli

.PHONY: all install uninstall check-deps

all:
	@echo "Available commands:"
	@echo "  make install   - Install bdo-cli"
	@echo "  make uninstall - Uninstall bdo-cli"

check-deps:
	@echo "Checking dependencies..."
	@command -v git >/dev/null 2>&1 || { echo "Error: Git is required but not installed"; exit 1; }
	@command -v gh >/dev/null 2>&1 || { echo "Error: GitHub CLI is required but not installed"; exit 1; }
	@echo "All dependencies found."

install: check-deps
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