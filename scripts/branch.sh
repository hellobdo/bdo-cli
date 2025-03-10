#!/bin/bash

# Debugging: Show received arguments
echo "Arguments received: $@"

# Ensure a branch name is provided
if [ -z "$1" ]; then
    echo "Usage: bdo branch <branch-name>"
    exit 1
fi

branch_name="$1"
echo "Creating and switching to branch: $branch_name"

# Create and switch to the new branch locally
git checkout -b "$branch_name"

# Push the new branch to remote
git push origin "$branch_name"