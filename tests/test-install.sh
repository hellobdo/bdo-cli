#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

TESTS_DIR="$(dirname "$0")"
INSTALL_SCRIPT="$(dirname "$TESTS_DIR")/install.sh"
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

# Test PATH configuration
run_test "PATH configuration check" \
         "/usr/local/bin" \
         "HOME=$TEST_HOME bash -c 'source $INSTALL_SCRIPT 2>/dev/null || true; echo \$PATH'"

# Print summary
echo -e "\n${YELLOW}Test Summary:${NC}"
echo -e "Total: $TOTAL"
echo -e "${GREEN}Passed: $PASSED${NC}"
echo -e "${RED}Failed: $FAILED${NC}"

# Exit with failure if any tests failed
[ $FAILED -eq 0 ] || exit 1 