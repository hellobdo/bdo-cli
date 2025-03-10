# BDO CLI

BDO CLI provides a collection of helpful shell scripts for Git, GitHub, and development workflows.

## Installation

Choose one of the following installation methods:

### 1. Direct Installation Script (Recommended)

```bash
curl -o- https://raw.githubusercontent.com/hellobdo/bdo-cli/main/install.sh | bash
```

### 2. Manual Download

You can download the latest release from our [GitHub Releases](https://github.com/hellobdo/bdo-cli/releases) page and follow these steps:

1. Download and extract the release
2. Make the installation script executable: `chmod +x install.sh`
3. Run the installation script: `./install.sh`

### 3. Using Docker

```bash
docker pull hellobdo/bdo-cli
docker run bdo-cli bdo-cli list
```

## Dependencies

### Required Dependencies
- Git - For repository operations
- GitHub CLI (`gh`) - For GitHub operations

### Optional Dependencies (for React features)
- Node.js and npm - Required only for React and Next.js operations:
  - `bdo-cli react`
  - `bdo-cli create-react`
  - `bdo-cli vitest`

## Available Commands

### Core Commands (no additional dependencies)
- `bdo-cli list` - Show all available commands
- `bdo-cli create <repo-name>` - Create and initialize a new repository
- `bdo-cli push` - Add, commit, and push changes
- `bdo-cli branch <branch-name>` - Create and push a new branch
- `bdo-cli checkout` - Reset to match remote main branch

### React Commands (requires Node.js and npm)
- `bdo-cli react` - Create a Vite React app
- `bdo-cli create-react` - Create a directory with a Vite React app
- `bdo-cli vitest` - Setup Vitest in a React project

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

## License

This project is licensed under the MIT License - see the LICENSE file for details.