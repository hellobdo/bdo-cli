#!/bin/bash

# Debug: Print received arguments
echo "Arguments received:" "$@"

# Get repository name from arguments
repo_name="$1"

if [ -z "$repo_name" ]; then
    echo "Error: Repository name is required"
    exit 1
fi

# Check if directory already exists
if [ -d "$repo_name" ]; then
    echo "Error: Directory '$repo_name' already exists"
    exit 1
fi

# Create the repository directory
mkdir "$repo_name"
echo "Created directory: $repo_name"

# Navigate to the new directory
cd "$repo_name" || exit

# Initialize git repository
git init
touch README.md
echo "# $repo_name" > README.md  # Add a header to the README with the name of the repo
git add .
git commit -m "Initial commit"

# Create remote repository on GitHub
gh repo create "$repo_name" --public --source=. --remote=origin

echo "Repository '$repo_name' created successfully."