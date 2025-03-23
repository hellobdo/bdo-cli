# BDO CLI

BDO CLI provides a collection of helpful shell scripts for Git, GitHub, and development workflows.

## Installation

## Requirements

Before installing, ensure you have the following prerequisites:
- **Git**: For repository operations
- **GitHub CLI**: For GitHub operations

These tools must be installed on your system before attempting to install bdo-cli.

## Available Commands

### Core Commands (no additional dependencies)
- `bdo list` - Show all available commands
- `bdo create <repo-name>` - Create and initialize a new repository
- `bdo push` - Add, commit, and push changes
- `bdo branch <branch-name>` - Create and push a new branch
- `bdo checkout` - Reset to match remote main branch

## Development

To contribute to BDO CLI:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Releasing New Versions

1. Tag the new version:
   ```bash
   git tag -a v1.x.x -m "Release v1.x.x"
   git push origin v1.x.x
   ```
2. Go to GitHub releases and create a new release from the tag