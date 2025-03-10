# BDO CLI

BDO CLI provides a collection of helpful shell scripts for Git, GitHub, and development workflows. There are two ways to install these scripts:

## Method 1: Using Homebrew (macOS and Linux)

If you have [Homebrew](https://brew.sh/) installed, you can install BDO CLI with a simple command:

```bash
brew install bdo-cli
```

## Method 2: Using Docker

You can also run BDO CLI using Docker:

```bash
# Build the Docker image
docker build -t bdo-cli .

# Run BDO CLI commands
docker run bdo-cli bdo-cli list
```

## Dependencies

Some scripts require additional tools:
- GitHub CLI (`gh`) - Used for GitHub operations
- Node.js and npm - Used for React and Next.js operations

## Available Commands

Once installed, you can run the following commands:

- `bdo-cli list` - Show all available commands
- `bdo-cli create <repo-name>` - Create and initialize a new repository
- `bdo-cli push` - Add, commit, and push changes
- `bdo-cli branch <branch-name>` - Create and push a new branch
- `bdo-cli react` - Create a Vite React app
- `bdo-cli checkout` - Reset to match remote main branch
- `bdo-cli create-react` - Create a directory with a Vite React app
- `bdo-cli vitest` - Setup Vitest in a React project

## Development

To contribute to BDO CLI:

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.