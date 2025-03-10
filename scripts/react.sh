#!/bin/bash

# Debugging: Show received arguments
echo "Arguments received: $@"

# Ensure an app name is provided
if [ -z "$1" ]; then
    echo "Usage: bdo react <app-name>"
    exit 1
fi

app_name="$1"
echo "Creating a reach app: $app_name"

# Create a Vite + React project
npm create vite@latest $app_name -- --template react

# Navigate into the project directory
cd $app_name || exit

# Install dependencies
npm install

# Install PropTypes
npm install --save prop-types

# Start the development server
npm run dev