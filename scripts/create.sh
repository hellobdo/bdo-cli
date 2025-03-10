#!/bin/bash

# Debugging: Show received arguments
echo "Arguments received: $@"

# Ensure a directory name is provided
if [ -z "$1" ]; then
    echo "Usage: bdo create <app-name>"
    exit 1
fi

echo "Creating a repo: $repo_name"

# Store the name of the app-name in a variable
repo_name="$1"

# Make a directory
mkdir $repo_name

# Navigate into the project directory
cd $repo_name || exit

# Initialize the Git repo
git init

# create a README.md file
touch README.md
echo "# $repo_name" > README.md  # Add a header to the README with the name of the repo
git add .
git commit -m "Initial commit"

# Create the GitHub repository remotely
gh repo create "$repo_name" --public --source=. --remote=origin

# Push the initial commit to GitHub
git push -u origin main