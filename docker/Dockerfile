# Use a minimal Alpine Linux base image
FROM alpine:latest

# Install prerequisites
RUN apk add --no-cache \
    bash \
    curl \
    git \
    gnupg \
    sudo \
    vim \
    zsh \
    && rm -rf /var/cache/apk/*

# Install chezmoi
RUN sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin

# Create a non-root user to run as
ARG USER=chezmoi
ARG USER_UID=1000
ARG USER_GID=1000

RUN addgroup -g $USER_GID $USER \
    && adduser -D -u $USER_UID -G $USER $USER \
    && echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

# Set up working directory and entrypoint
WORKDIR /home/$USER
USER $USER

# Default command
ENTRYPOINT ["chezmoi"]
CMD ["--help"]
