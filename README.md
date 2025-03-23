# BDO CLI

BDO CLI provides a collection of helpful shell scripts for Git, GitHub, and development workflows.

## Installation



## Dependencies

### Required Dependencies
- Git - For repository operations
- GitHub CLI (`gh`) - For GitHub operations

## Available Commands

### Core Commands (no additional dependencies)
- `bdo-cli list` - Show all available commands
- `bdo-cli create <repo-name>` - Create and initialize a new repository
- `bdo-cli push` - Add, commit, and push changes
- `bdo-cli branch <branch-name>` - Create and push a new branch
- `bdo-cli checkout` - Reset to match remote main branch

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