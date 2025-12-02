#!/bin/bash

# Debug: Print received arguments
echo "Arguments received:" "$@"

# Create a file called .envrc with text inside
echo "source .venv/bin/activate" > .envrc

# Run direnv allow
direnv allow

# Display success
echo "File .envrc created and allowed via direnv"
