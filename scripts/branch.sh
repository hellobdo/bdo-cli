#!/bin/bash

# Debug: Print received arguments
echo "Arguments received:" "$@"

# Get branch name from arguments
BRANCH_NAME="$1"

if [ -z "$BRANCH_NAME" ]; then
    echo "Error: Branch name is required"
    exit 1
fi

# Create and switch to the new branch
git checkout -b "$BRANCH_NAME"

# Push the branch to the remote repository
git push -u origin "$BRANCH_NAME"

echo "Branch '$BRANCH_NAME' created and pushed to remote."