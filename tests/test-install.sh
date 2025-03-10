#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Get absolute paths
TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$TESTS_DIR")"
INSTALL_SCRIPT="$REPO_ROOT/install.sh"

TOTAL=0
PASSED=0
FAILED=0

# Create a temporary test directory
TEST_HOME=$(mktemp -d)
trap 'rm -rf "$TEST_HOME"' EXIT

# Run a test and check its result
run_test() {
    local test_name="$1"
    local expected="$2"
    local actual="$3"
    
    ((TOTAL++))
    
    echo -e "\nRunning test: ${YELLOW}$test_name${NC}"
    
    if [[ "$actual" == *"$expected"* ]]; then
        echo -e "${GREEN}✓ Passed${NC}"
        ((PASSED++))
    else
        echo -e "${RED}✗ Failed${NC}"
        echo "Expected: $expected"
        echo "Got: $actual"
        ((FAILED++))
    fi
}

# Test PATH configuration
echo -e "\nTesting PATH configuration..."
PATH_TEST=$(echo "testcli" | HOME="$TEST_HOME" bash -c "source $INSTALL_SCRIPT >/dev/null 2>&1 || true; echo \$PATH")
run_test "PATH configuration check" "/usr/local/bin" "$PATH_TEST"

# Copy necessary files to test directory
mkdir -p "$TEST_HOME/bdo-cli"/{bin,scripts}
cp "$REPO_ROOT/bin/bdo-cli" "$TEST_HOME/bdo-cli/bin/"
cp "$REPO_ROOT/install.sh" "$TEST_HOME/bdo-cli/"
cp -r "$REPO_ROOT/scripts/"* "$TEST_HOME/bdo-cli/scripts/"

# Create mock directories
mkdir -p "$TEST_HOME/usr/local/bin"

# Mock sudo for testing
function sudo() {
    if [[ "$1" == "rm" ]]; then
        rm -f "${@:3}"
    elif [[ "$1" == "ln" ]]; then
        ln -s "${@:3}"
    fi
}
export -f sudo

# Test default prefix installation
echo -e "\nTesting default prefix installation..."
TEST_INSTALL_DIR="$TEST_HOME/.bdo-cli"
mkdir -p "$TEST_INSTALL_DIR"
(cd "$TEST_HOME/bdo-cli" && echo "bdo" | HOME="$TEST_HOME" LOCAL_BIN="$TEST_HOME/usr/local/bin" SUDO_COMMAND="mock" ./install.sh > /dev/null 2>&1)
SAVED_PREFIX=$(cat "$TEST_INSTALL_DIR/prefix" 2>/dev/null || echo "")
run_test "Default prefix should be 'bdo'" "bdo" "$SAVED_PREFIX"

# Test custom prefix installation
echo -e "\nTesting custom prefix installation..."
rm -rf "$TEST_INSTALL_DIR"
mkdir -p "$TEST_INSTALL_DIR"
(cd "$TEST_HOME/bdo-cli" && echo "mycli" | HOME="$TEST_HOME" LOCAL_BIN="$TEST_HOME/usr/local/bin" SUDO_COMMAND="mock" ./install.sh > /dev/null 2>&1)
SAVED_PREFIX=$(cat "$TEST_INSTALL_DIR/prefix" 2>/dev/null || echo "")
run_test "Custom prefix should be 'mycli'" "mycli" "$SAVED_PREFIX"

# Test symlink creation
echo -e "\nTesting symlink creation..."
SYMLINK_DEFAULT="$TEST_HOME/usr/local/bin/bdo"
SYMLINK_CUSTOM="$TEST_HOME/usr/local/bin/mycli"
run_test "Default prefix symlink exists" "true" "$([ -L "$SYMLINK_DEFAULT" ] && echo true || echo false)"
run_test "Custom prefix symlink exists" "true" "$([ -L "$SYMLINK_CUSTOM" ] && echo true || echo false)"

# Test invalid prefix
echo -e "\nTesting invalid prefix..."
rm -rf "$TEST_INSTALL_DIR"
mkdir -p "$TEST_INSTALL_DIR"
INVALID_OUTPUT=$(cd "$TEST_HOME/bdo-cli" && echo "invalid@prefix" | HOME="$TEST_HOME" LOCAL_BIN="$TEST_HOME/usr/local/bin" SUDO_COMMAND="mock" ./install.sh 2>&1)
run_test "Invalid prefix should be rejected" "Error: Command prefix can only contain letters, numbers, and hyphens" "$INVALID_OUTPUT"

# Print summary
echo -e "\n${YELLOW}Test Summary:${NC}"
echo -e "Total: $TOTAL"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"

# Exit with failure if any tests failed
[ $FAILED -eq 0 ] || exit 1 