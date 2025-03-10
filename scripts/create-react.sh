#!/bin/bash

# Debugging: Show received arguments
echo "Arguments received: $@"

# Ensure a directory name is provided
if [ -z "$1" ]; then
    echo "Usage: bdo create-react <app-name>"
    exit 1
fi

echo "Creating a reach app: $app_name"

# Store the name of the app-name in a variable
app_name="$1"

# Make a directory
mkdir $app_name

# Navigate into the project directory
cd $app_name || exit

# Create a Vite + React project in the folder created
npm create vite@latest . -- --template react

# Initialize the Git repo
git init
git add .
git commit -m "Initial commit"

# Create the GitHub repository
gh repo create "$app_name" --public --source=. --remote=origin

# Push the initial commit to GitHub
git push -u origin main

# Install dependencies locally
npm install

# Install PropTypes
npm install --save prop-types

# Start the development server
npm run dev