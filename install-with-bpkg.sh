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
bpkg install ${GITHUB_USER}/${REPO_NAME} -g

# Step 3: Check and install dependencies using bpkg getdeps
echo -e "\n${YELLOW}Checking for dependencies...${NC}"
if command -v bpkg &> /dev/null; then
    echo -e "${YELLOW}Installing dependencies with bpkg getdeps...${NC}"
    # Run bpkg getdeps to recursively install all dependencies
    bpkg getdeps ${GITHUB_USER}/${REPO_NAME}
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Dependencies installed successfully${NC}"
    else
        echo -e "${RED}⚠️ There was an issue installing dependencies${NC}"
        echo -e "${YELLOW}You can try installing dependencies manually:${NC}"
        echo -e "bpkg getdeps ${GITHUB_USER}/${REPO_NAME}"
        # Continue with installation even if dependencies failed
    fi
else
    echo -e "${RED}❌ Cannot install dependencies: bpkg is not available${NC}"
fi

# Step 4: Verify the installation
if command -v bdo &> /dev/null; then
    echo -e "\n${GREEN}🎉 bdo-cli has been successfully installed!${NC}"
    echo -e "${YELLOW}Try running: ${GREEN}bdo help${NC}"
else
    echo -e "\n${RED}❌ Installation may have failed. Please check the output above for errors.${NC}"
    echo -e "${YELLOW}You can try installing manually:${NC}"
    echo -e "bpkg install ${GITHUB_USER}/${REPO_NAME} -g"
    exit 1
fi