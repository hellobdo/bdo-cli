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

# Run a test and check its result
run_test() {
    local test_name="$1"
    local expected="$2"
    local command="$3"
    
    ((TOTAL++))
    
    echo -e "\nRunning test: ${YELLOW}$test_name${NC}"
    result=$(eval "$command" 2>&1)
    
    if [[ "$result" == *"$expected"* ]]; then
        echo -e "${GREEN}✓ Passed${NC}"
        ((PASSED++))
    else
        echo -e "${RED}✗ Failed${NC}"
        echo "Expected: $expected"
        echo "Got: $result"
        ((FAILED++))
    fi
}

# Test help command
run_test "Help command shows available commands" \
         "Available commands:" \
         "$CLI_PATH help"

# Test create command validation
run_test "Create command requires repository name" \
         "Usage: bdo create" \
         "$CLI_PATH create"

# Test branch command validation
run_test "Branch command requires branch name" \
         "Usage: bdo branch" \
         "$CLI_PATH branch"

# Test Node.js dependency check
run_test "React command checks for Node.js" \
         "Node.js and npm are required" \
         "PATH='' $CLI_PATH react"

# Print summary
echo -e "\n${YELLOW}Test Summary:${NC}"
echo -e "Total: $TOTAL"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"

# Exit with failure if any tests failed
[ $FAILED -eq 0 ] || exit 1 