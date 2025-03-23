#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Uninstalling bdo-cli...${NC}"

# Get the command name from the calling script
COMMAND_NAME=$(basename "$0")
if [[ "$COMMAND_NAME" == "remove.sh" ]]; then
    # If run directly as remove.sh, try to detect the CLI command name
    # from the calling script's name or the command that called this script
    PARENT_COMMAND=$(ps -o comm= $PPID 2>/dev/null || echo "")
    if [[ -n "$PARENT_COMMAND" && "$PARENT_COMMAND" != "bash" && "$PARENT_COMMAND" != "sh" ]]; then
        COMMAND_NAME="$PARENT_COMMAND"
    else
        # Default or fallback
        COMMAND_NAME="bdo"
    fi
fi

# Find where the command is installed
COMMAND_PATH=$(which "$COMMAND_NAME" 2>/dev/null)

if [ -z "$COMMAND_PATH" ]; then
    echo -e "${RED}Installation not found in PATH for command: ${COMMAND_NAME}${NC}"
    echo -e "${YELLOW}If you know where it's installed, you can manually remove:${NC}"
    echo "  - The executable (usually in ~/.local/bin or /usr/local/bin)"
    echo "  - The 'bdo-cli' library directory (usually in ~/.local/lib or /usr/local/lib)"
    exit 1
fi

# Get the bin directory
BIN_DIR=$(dirname "$COMMAND_PATH")
# Get the prefix (parent of bin directory)
PREFIX_DIR=$(dirname "$BIN_DIR")
# Set the library directory
LIB_DIR="${PREFIX_DIR}/lib/bdo-cli"

echo -e "${YELLOW}Found bdo-cli installation:${NC}"
echo "  - Command: ${COMMAND_NAME}"
echo "  - Executable: ${COMMAND_PATH}"
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
rm -f "$COMMAND_PATH" && echo "  - Removed executable: $COMMAND_PATH"
if [ -d "$LIB_DIR" ]; then
    rm -rf "$LIB_DIR" && echo "  - Removed library: $LIB_DIR"
fi

# Verify removal
if [ ! -f "$COMMAND_PATH" ] && [ ! -d "$LIB_DIR" ]; then
    echo -e "${GREEN}bdo-cli has been successfully uninstalled!${NC}"
else
    echo -e "${RED}Error: Some files could not be removed. You may need sudo permissions.${NC}"
    echo -e "${YELLOW}Try running:${NC}"
    echo "  sudo rm -f $COMMAND_PATH"
    echo "  sudo rm -rf $LIB_DIR"
    exit 1
fi 