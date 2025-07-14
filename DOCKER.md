# Docker-based Chezmoi Dotfiles Management

This setup allows you to manage your dotfiles using Chezmoi in a Docker container, providing isolation and consistency across different machines.

## Prerequisites

- Docker
- Git
- Bash (or compatible shell)

## Setup

1. **Build the Docker image**:
   ```bash
   ./chezmoi-docker --build
   ```
   This needs to be done only once or when you update the Dockerfile.

## Usage

### Basic Commands

Use the `chezmoi-docker` wrapper script to run any chezmoi command:

```bash
# Initialize chezmoi
./chezmoi-docker init --apply https://github.com/yourusername/your-dotfiles.git

# Add a new dotfile
./chezmoi-docker add ~/.bashrc

# Apply changes
./chezmoi-docker apply

# Edit a tracked file
./chezmoi-docker edit ~/.bashrc

# See what would be changed
./chezmoi-docker diff
```

### Testing Changes

1. Start the test environment:
   ```bash
   mkdir -p test/home
   docker-compose -f docker-compose.test.yml up -d
   docker-compose -f docker-compose.test.yml exec test bash
   ```

2. Inside the test container, you can test your dotfiles:
   ```bash
   # Initialize chezmoi in the test environment
   chezmoi init /dotfiles
   
   # Apply your dotfiles
   chezmoi apply -v
   
   # Test your shell, editors, etc.
   zsh
   vim
   ```

3. When done, exit the container and clean up:
   ```bash
   exit
   docker-compose -f docker-compose.test.yml down
   ```

## How It Works

- The `chezmoi-docker` script runs Chezmoi in a container with proper volume mounts:
  - Your home directory is mounted read-write
  - The dotfiles repository is mounted at `/dotfiles`
  - SSH agent forwarding is supported
  - User/group IDs are preserved

- The test environment provides a clean Alpine Linux container to test your dotfiles before applying them to your host system.

## Updating

To update the Docker image after making changes to the Dockerfile:

```bash
./chezmoi-docker --build
```

## Troubleshooting

- If you get permission errors, ensure your user has access to the Docker daemon
- For SSH agent forwarding issues, make sure `SSH_AUTH_SOCK` is set in your host environment
- Check the Docker logs if the container fails to start

## Security Notes

- The container runs with the same user ID as your host user
- SSH agent forwarding is enabled by default for Git operations
- The container is ephemeral - no data is stored between runs except what's in your repository
