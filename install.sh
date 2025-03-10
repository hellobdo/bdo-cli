#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Installation directory
INSTALL_DIR="$HOME/.bdo-cli"

# Allow overriding /usr/local/bin in tests
LOCAL_BIN="${LOCAL_BIN:-/usr/local/bin}"

# Prompt for command prefix
read -p "Enter your preferred command prefix (default: bdo): " CMD_PREFIX
CMD_PREFIX=${CMD_PREFIX:-bdo}

# Validate prefix (only allow alphanumeric and hyphen)
if ! [[ $CMD_PREFIX =~ ^[a-zA-Z0-9-]+$ ]]; then
    echo -e "${RED}Error: Command prefix can only contain letters, numbers, and hyphens${NC}"
    exit 1
fi

# Check for required dependencies
check_dependency() {
    if ! command -v $1 &> /dev/null; then
        echo -e "${RED}❌ $2 is not installed. Please install it first.${NC}"
        exit 1
    else
        echo -e "${GREEN}✅ $2 is installed${NC}"
    fi
}

# Skip dependency checks in test mode
if [ -z "$SUDO_COMMAND" ]; then
    echo "Checking required dependencies..."
    check_dependency "git" "Git"
    check_dependency "gh" "GitHub CLI"
fi

# Create installation directory
echo -e "\nCreating installation directory..."
rm -rf "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR"/{bin,scripts}

# Determine if we're installing from local files or remote repository
if [ -f "$(dirname "$0")/bin/bdo-cli" ]; then
    echo "Installing from local files..."
    SOURCE_DIR="$(dirname "$0")"
else
    echo "Installing from remote repository..."
    # Create a temporary directory for cloning
    TEMP_DIR=$(mktemp -d)
    trap 'rm -rf "$TEMP_DIR"' EXIT

    # Clone repository
    echo "Cloning bdo-cli repository..."
    git clone https://github.com/hellobdo/bdo-cli.git "$TEMP_DIR"
    SOURCE_DIR="$TEMP_DIR"
fi

# Copy only necessary files
echo "Installing CLI..."
cp "$SOURCE_DIR/bin/bdo-cli" "$INSTALL_DIR/bin/"
cp -r "$SOURCE_DIR/scripts/"*.sh "$INSTALL_DIR/scripts/" 2>/dev/null || true
if [ -d "$SOURCE_DIR/scripts/next-js" ]; then
    mkdir -p "$INSTALL_DIR/scripts/next-js"
    cp -r "$SOURCE_DIR/scripts/next-js/"*.sh "$INSTALL_DIR/scripts/next-js/"
fi

# Make scripts executable
echo "Making scripts executable..."
chmod +x "$INSTALL_DIR/bin/bdo-cli"
find "$INSTALL_DIR/scripts" -type f -name "*.sh" -exec chmod +x {} \;

# Create symlink with custom prefix
echo "Creating symlink..."
SYMLINK="$LOCAL_BIN/$CMD_PREFIX"
sudo rm -f "$SYMLINK"
sudo ln -s "$INSTALL_DIR/bin/bdo-cli" "$SYMLINK"

# Add to PATH if not already there
if [[ ":$PATH:" != *":$LOCAL_BIN:"* ]]; then
    echo "export PATH=\"$LOCAL_BIN:\$PATH\"" >> ~/.bashrc
    echo "export PATH=\"$LOCAL_BIN:\$PATH\"" >> ~/.zshrc
fi

# Save the prefix for future reference
echo "$CMD_PREFIX" > "$INSTALL_DIR/prefix"

echo -e "\n${GREEN}🎉 CLI has been successfully installed!${NC}"
echo -e "\n${GREEN}Run '$CMD_PREFIX help' to see available commands${NC}"
echo -e "${YELLOW}Please restart your terminal or run: source ~/.bashrc (or ~/.zshrc)${NC}" 