# Installing BDO Shell Scripts

BDO Shell Scripts provide a collection of helpful shell scripts for Git, GitHub, and development workflows. There's one way to install these scripts:

## Method 1: Using Homebrew (macOS and Linux)

If you have [Homebrew](https://brew.sh/) installed, you can install BDO Shell Scripts with a simple command:

```bash
# Add the tap (only needed once)
brew tap hellobdo/bdo

# Install the formula
brew install bdo
```

## Dependencies

Some scripts require additional tools:
- GitHub CLI (`gh`) - Used for GitHub operations
- Node.js and npm - Used for React and Next.js operations

## Available Commands

Once installed, you can run the following commands:

- `bdo list` - Show all available commands
- `bdo create <repo-name>` - Create and initialize a new repository
- `bdo push` - Add, commit, and push changes
- `bdo branch <branch-name>` - Create and push a new branch
- `bdo react` - Create a Vite React app
- `bdo checkout` - Reset to match remote main branch
- `bdo create-react` - Create a directory with a Vite React app
- `bdo vitest` - Setup Vitest in a React project