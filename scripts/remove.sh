#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Uninstalling bdo-cli...${NC}"

# Find where bdo is installed
BDO_PATH=$(which bdo 2>/dev/null)

if [ -z "$BDO_PATH" ]; then
    echo -e "${RED}bdo-cli installation not found in PATH.${NC}"
    echo -e "${YELLOW}If you know where it's installed, you can manually remove:${NC}"
    echo "  - The 'bdo' executable (usually in ~/.local/bin or /usr/local/bin)"
    echo "  - The 'bdo-cli' library directory (usually in ~/.local/lib or /usr/local/lib)"
    exit 1
fi

# Get the bin directory
BIN_DIR=$(dirname "$BDO_PATH")
# Get the prefix (parent of bin directory)
PREFIX_DIR=$(dirname "$BIN_DIR")
# Set the library directory
LIB_DIR="${PREFIX_DIR}/lib/bdo-cli"

echo -e "${YELLOW}Found bdo-cli installation:${NC}"
echo "  - Executable: ${BDO_PATH}"
echo "  - Library: ${LIB_DIR}"

# Confirm removal
echo
echo -e "${YELLOW}This will remove bdo-cli from your system.${NC}"
read -p "Continue? [y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}Uninstallation cancelled.${NC}"
    exit 0
fi

# Remove files
echo -e "${YELLOW}Removing bdo-cli...${NC}"
rm -f "$BDO_PATH" && echo "  - Removed executable: $BDO_PATH"
if [ -d "$LIB_DIR" ]; then
    rm -rf "$LIB_DIR" && echo "  - Removed library: $LIB_DIR"
fi

# Verify removal
if [ ! -f "$BDO_PATH" ] && [ ! -d "$LIB_DIR" ]; then
    echo -e "${GREEN}bdo-cli has been successfully uninstalled!${NC}"
else
    echo -e "${RED}Error: Some files could not be removed. You may need sudo permissions.${NC}"
    echo -e "${YELLOW}Try running:${NC}"
    echo "  sudo rm -f $BDO_PATH"
    echo "  sudo rm -rf $LIB_DIR"
    exit 1
fi 