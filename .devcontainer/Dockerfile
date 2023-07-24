# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.202.5/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use hirsuite or bionic on local arm64/Apple Silicon): hirsute, focal, bionic
ARG VARIANT="hirsute"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Update all Ubuntu Packages
RUN apt update && apt upgrade -y

# Install curl
RUN apt install curl

# Install node.js
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN apt install -y nodejs

## Install the Hardhat (hh) shortcut tool
RUN npm install -g hardhat-shorthand