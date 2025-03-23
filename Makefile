# Default PREFIX is /usr/local, but bpkg may override this
PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib/bdo-cli
# Default command name
COMMAND_NAME ?= bdo

.PHONY: all install

all:
	@echo "Available commands:"
	@echo "  make install               - Install bdo-cli"
	@echo "  make install COMMAND_NAME=xyz  - Install with custom command name"

install:
	@echo "Installing bdo-cli to $(BINDIR) as '$(COMMAND_NAME)'..."
	install -d $(BINDIR)
	install -d $(LIBDIR)/scripts
	install -m 755 bin/bdo-cli $(BINDIR)/$(COMMAND_NAME)
	install -m 755 scripts/* $(LIBDIR)/scripts/
	@echo "Installation complete. Run '$(COMMAND_NAME) help' to get started." 