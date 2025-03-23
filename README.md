# BDO CLI

BDO CLI provides a collection of helpful shell scripts for Git, GitHub, and development workflows.

## Installation

```bash
# One-line installer (installs bpkg if needed)
curl -Lo- https://raw.githubusercontent.com/hellobdo/bdo-cli/main/install-with-bpkg.sh | bash
```

## Requirements

Before installing, ensure you have the following prerequisites:
- **Git**: For repository operations
- **GitHub CLI**: For GitHub operations

These tools must be installed on your system before attempting to install bdo-cli.

## Available Commands

- `bdo help` - Show all available commands
- `bdo create <repo-name>` - Create and initialize a new repository
- `bdo push` - Add, commit, and push changes
- `bdo branch <branch-name>` - Create and push a new branch
- `bdo checkout` - Reset to match remote main branch

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.