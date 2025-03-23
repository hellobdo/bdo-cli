#!/bin/bash

# Get the current branch name
BRANCH_NAME=$(git branch --show-current)

# Make sure we're not on main branch
if [ "$BRANCH_NAME" = "main" ] || [ "$BRANCH_NAME" = "master" ]; then
    echo "You are already on the main branch."
    exit 0
fi

# Switch to main branch
git switch main || { echo "Failed to switch to main"; exit 1; }

# Deletes the local branch
git branch -d "$BRANCH_NAME"

# Ensure main is up-to-date
git fetch origin
git pull origin main

# Reset local main to match remote main (dangerous if you have local changes)
git reset --hard origin/main

echo "Branch $BRANCH_NAME deleted and main is now up-to-date!"