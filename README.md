# Docker-based Chezmoi Dotfiles Management

This repository contains my personal dotfiles managed with [Chezmoi](https://www.chezmoi.io/), containerized for portability and consistency across different machines.

## Features

- 🐳 **Containerized Environment**: No need to install Chezmoi on your host system
- 🧪 **Testing**: Dedicated test environment to verify changes before applying them
- 🔒 **Security**: Runs as your user with proper permissions
- 🔄 **Consistent**: Same environment across all your machines

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Git](https://git-scm.com/)
- Bash or compatible shell

## Quick Start

1. Clone this repository:
   ```bash
   git clone https://github.com/levonk/levonk-dotfiles.git
   cd levonk-dotfiles
   ```

2. Build the Docker image:
   ```bash
   bin/chezmoi-docker --build
   ```

3. Initialize and apply dotfiles:
   ```bash
   bin/chezmoi-docker init --apply https://github.com/levonk/levonk-dotfiles.git
   ```

## Usage

Use the `chezmoi-docker` wrapper script to run any chezmoi command:

```bash
# Add a new dotfile
bin/chezmoi-docker add ~/.bashrc

# Apply changes
bin/chezmoi-docker apply

# Edit a tracked file
bin/chezmoi-docker edit ~/.bashrc

# See what would be changed
bin/chezmoi-docker diff
```

## Testing Changes

1. Start the test environment:
   ```bash
   mkdir -p test/home
   docker-compose -f docker/docker-compose.test.yml up -d
   docker-compose -f docker/docker-compose.test.yml exec test bash
   ```

2. Inside the test container:
   ```bash
   # Option 1: Initialize chezmoi from the remote repository (Git, recommended for production)
   chezmoi init --apply https://github.com/levonk/levonk-dotfiles.git

   # Option 2: Initialize chezmoi using the local source directory (useful for local testing)
   chezmoi init --source /dotfiles

   # Or, to re-initialize and force use of local files (useful for testing):
   chezmoi init --source /dotfiles --force

   # Apply your dotfiles
   chezmoi apply -v

   # Test your shell, editors, etc.
   zsh
   vim
   ```

3. When done, clean up:
   ```bash
   exit
   docker-compose -f docker/docker-compose.test.yml down
   ```

## Project Structure

```
.
├── docker/                  # Docker-related files
│   ├── Dockerfile          # Main Dockerfile for chezmoi
│   ├── Dockerfile.test     # Test environment Dockerfile
│   └── docker-compose.test.yml  # Test environment configuration
├── chezmoi/                # Your dotfiles (managed by chezmoi)
├── bin/
│   └── chezmoi-docker      # Wrapper script for running chezmoi in Docker
└── README.md               # This file
```

## Security Notes

- The container runs with the same user ID as your host user
- SSH agent forwarding is enabled by default for Git operations
- The container is ephemeral - no data is stored between runs except what's in your repository

## License

This project is licensed under the [MIT License](LICENSE).