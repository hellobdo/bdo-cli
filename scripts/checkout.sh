#!/bin/bash

# Debugging: Show received arguments
BRANCH_NAME=$(git branch --show-current)

# Prevent deleting 'main' by mistake
if [[ "$BRANCH_NAME" == "main" ]]; then
  echo "You are already on 'main'. Cannot delete 'main' branch."
  exit 1
fi

echo "Switching to main and deleting branch: $BRANCH_NAME"

# Switch to main branch
git switch main || { echo "Failed to switch to main"; exit 1; }

# Deletes the local branch
git branch -d $BRANCH_NAME

# Ensure main is up-to-date
git fetch origin
git pull origin main

# Reset local main to match remote main (dangerous if you have local changes)
git reset --hard origin/main

echo "Branch $BRANCH_NAME deleted and main is now up-to-date!"