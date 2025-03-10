#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

TESTS_DIR="$(dirname "$0")"
CLI_PATH="$(dirname "$TESTS_DIR")/bin/bdo-cli"
TOTAL=0
PASSED=0
FAILED=0

# Create test directory
TEST_DIR=$(mktemp -d)
trap 'rm -rf "$TEST_DIR"' EXIT

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

# Test help command with default prefix
echo "Testing help command with default prefix..."
mkdir -p "$TEST_DIR/.bdo-cli"
echo "bdo" > "$TEST_DIR/.bdo-cli/prefix"
HELP_OUTPUT=$(HOME="$TEST_DIR" $CLI_PATH help)
run_test "Help shows default prefix" "bdo create" "$HELP_OUTPUT"

# Test help command with custom prefix
echo -e "\nTesting help command with custom prefix..."
echo "mycli" > "$TEST_DIR/.bdo-cli/prefix"
HELP_OUTPUT=$(HOME="$TEST_DIR" $CLI_PATH help)
run_test "Help shows custom prefix" "mycli create" "$HELP_OUTPUT"

# Test error messages with custom prefix
echo -e "\nTesting error messages with custom prefix..."
ERROR_OUTPUT=$(HOME="$TEST_DIR" $CLI_PATH create 2>&1)
run_test "Usage error shows custom prefix" "Usage: mycli create" "$ERROR_OUTPUT"

# Test unknown command with custom prefix
UNKNOWN_OUTPUT=$(HOME="$TEST_DIR" $CLI_PATH unknown-cmd 2>&1)
run_test "Unknown command shows custom prefix" "Run 'mycli help'" "$UNKNOWN_OUTPUT"

# Test missing prefix file (should default to 'bdo')
echo -e "\nTesting missing prefix file..."
rm "$TEST_DIR/.bdo-cli/prefix"
HELP_OUTPUT=$(HOME="$TEST_DIR" $CLI_PATH help)
run_test "Missing prefix defaults to 'bdo'" "bdo create" "$HELP_OUTPUT"

# Print summary
echo -e "\n${YELLOW}Test Summary:${NC}"
echo -e "Total: $TOTAL"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"

# Exit with failure if any tests failed
[ $FAILED -eq 0 ] || exit 1 