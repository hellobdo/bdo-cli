#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# GitHub repository info
GITHUB_USER="hellobdo"
REPO_NAME="bdo-cli"

echo -e "${YELLOW}Installing bdo-cli using bpkg...${NC}"

# Check for Git
if ! command -v git &> /dev/null; then
    echo -e "${RED}Git is required but not installed.${NC}"
    exit 1
fi

# Check for GitHub CLI
if ! command -v gh &> /dev/null; then
    echo -e "${RED}GitHub CLI is required but not installed.${NC}"
    exit 1
fi

# Ask for custom command name
echo -e "${YELLOW}Choose a command name for the CLI tool:${NC}"
read -p "Command name [bdo]: " COMMAND_NAME
COMMAND_NAME=${COMMAND_NAME:-bdo}
echo -e "Will install as: ${GREEN}${COMMAND_NAME}${NC}"

# Step 1: Check if bpkg is installed
if ! command -v bpkg &> /dev/null; then
    echo -e "${YELLOW}bpkg not found. Installing bpkg...${NC}"
    
    # Install bpkg using the official installer
    curl -Lo- http://get.bpkg.sh | bash
    
    # Verify bpkg installation
    if ! command -v bpkg &> /dev/null; then
        echo -e "${RED}Failed to install bpkg. Please install it manually:${NC}"
        echo "curl -Lo- http://get.bpkg.sh | bash"
        exit 1
    fi
    
    echo -e "${GREEN}✅ bpkg installed successfully${NC}"
else
    echo -e "${GREEN}✅ bpkg is already installed${NC}"
fi

# Step 2: Install bdo-cli using bpkg
echo -e "\n${YELLOW}Installing bdo-cli...${NC}"
bpkg install ${GITHUB_USER}/${REPO_NAME} -g COMMAND_NAME=${COMMAND_NAME}

# Step 3: Verify the installation
if command -v ${COMMAND_NAME} &> /dev/null; then
    echo -e "\n${GREEN}🎉 bdo-cli has been successfully installed as '${COMMAND_NAME}'!${NC}"
    echo -e "${YELLOW}Try running: ${GREEN}${COMMAND_NAME} help${NC}"
else
    echo -e "\n${RED}❌ Installation may have failed. Please check the output above for errors.${NC}"
    echo -e "${YELLOW}You can try installing manually:${NC}"
    echo -e "bpkg install ${GITHUB_USER}/${REPO_NAME} -g COMMAND_NAME=${COMMAND_NAME}"
    exit 1
fi