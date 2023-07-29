# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Added `listLandsByOwner` function to return list of lands owned by a specific address.
- Created test cases for the contract in Typescript.
- Added `HardhatUserConfig` for the project.

### Changed

- Updated land struct to include `isRegistered` boolean variable.
- Updated mapping `lands` to keep track of all lands.
- Added `ownerToLands` mapping to keep track of lands owned by a particular address.

### Fixed

- Fixed issues with land ownership transfer in `transferLand` function.

## [0.1.0] - 2023-07-27

### Added

- Initial release of the Land Registry smart contract.
- Implemented basic functions such as `registerLand`, `transferLand`, `sellLand`, and `verifyLand`.
