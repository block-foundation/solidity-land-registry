# Solidity DevContainer

DevContainer for Solidity development, that includes:

1. Solidity compiler (solc).
2. Node.js for running tests and scripts.
3. Truffle suite for smart contract compilation, deployment, and testing.
4. Ganache for setting up a local Ethereum blockchain.


In this configuration, we are installing the Solidity extension for VS Code, which provides syntax highlighting, auto-completion, and other helpful features for Solidity development.

In addition, we forward port 8545 so that you can interact with Ganache from your local machine.

Once you have these files, you can use the "Remote-Containers: Open Folder in Container..." command in Visual Studio Code to start developing in your new environment.

Please remember that Docker and the Remote Development extension pack need to be installed in your local environment for DevContainers to work.
