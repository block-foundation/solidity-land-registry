<div align="right">

  [![license](https://img.shields.io/github/license/block-foundation/manifesto?color=green&label=license&style=flat-square)](LICENSE.md)
  ![stars](https://img.shields.io/github/stars/block-foundation/manifesto?color=blue&label=stars&style=flat-square)
  ![contributors](https://img.shields.io/github/contributors/block-foundation/manifesto?color=blue&label=contributors&style=flat-square)

</div>

---

<div>
    <img align="right" src="https://raw.githubusercontent.com/block-foundation/brand/master/logo/logo_gray.png" width="96" alt="Block Foundation Logo">
    <h1 align="left">Decentralized Land Registry</h1>
    <h3 align="left">Block Foundation Smart Contract Series [Solidity]</h3>
</div>

---


<div>
<img align="right" width="75%" src="https://raw.githubusercontent.com/block-foundation/brand/master/image/repository_cover/block_foundation-structure-03-accent.jpg"  alt="Block Foundation">
<br>
<details open="open">
<summary>Table of Contents</summary>
  
- [Introduction](#style-guide)
- [Quick Start](#quick-start)
- [Contract](#contract)
- [Development Resources](#development-resources)
- [Legal Information](#legal-information)
  - [Copyright](#copyright)
  - [License](#license)
  - [Warning](#warning)
  - [Disclaimer](#disclaimer)

</details>
</div>

<br clear="both"/>

## Introduction

Welcome to the Decentralized Land Registry project, an open-source venture that aims to redefine land transactions with the power of blockchain. Leveraging advanced blockchain technology, this project introduces an innovative way to manage and conduct land transactions transparently, securely, and efficiently.

The traditional land registry systems are often fraught with inefficiencies, potential for fraud, and lack of transparency. Our solution, a blockchain-based land registry, addresses these issues head-on by providing an immutable and public record of land transactions, drastically reducing the potential for fraud and manipulation. By combining cryptography and consensus algorithms, blockchain technology ensures that once data is added to the blockchain, it is virtually impossible to change.

This is an example of  a smart contract for a land registry system where an owner can register their land, update the land details, and even transfer ownership in a secure way. This contract makes land transactions more transparent and trustworthy.

The primary functionalities include:

1. Registration: When a user first registers a parcel of land, they are recorded as the owner of that parcel in the global state of the smart contract.

2. Land Update: The owner can update the details of their registered land. Any updates are recorded in the global state, ensuring that a history of changes is kept.

3. Ownership Transfer: If the owner decides to transfer their land, the contract allows for a seamless and secure transfer of ownership.

This Decentralized Land Registry project is set to revolutionize how we view land transactions, bringing about a new level of transparency and security. We're excited to embark on this journey towards a more efficient, reliable, and secure system for land transactions, and we warmly invite you to explore, contribute, and grow with us in this endeavor.

## Quick Start

> Install

``` sh
npm i
```

> Compile

``` sh
npm run compile
```

## Contract

This is a simple implementation and can be expanded to include more complex features, like adding permissions to prevent unauthorized people from registering or transferring land, or adding events to keep track of every time a piece of land is registered or transferred.

In this contract:

- `registerLand()` allows an address to register a new parcel of land with its location and a unique parcel ID. Emits a LandRegistered event when land is registered.
- `transferLand()` allows the current owner of a land parcel to transfer it to a new owner. Emits a LandTransferred event when land is transferred.
- `sellLand()` allows a landowner to sell their land to a buyer. This also involves the transfer of Ether (the currency on Ethereum) from the buyer to the seller, representing the payment for the land.
- `verifyLand()` allows anyone to verify the details of a land parcel.

Moreover:

- `price` on the `Land struct` handles selling land parcels.
- `onlyLandOwner` modifier to ensures that only the owner of a land parcel can perform certain actions.

## Development Resources

## Other Repositories

| Smart Contract                | `Solidity`  | `Teal`      |
| ----------------------------- | ----------- | ----------- |
| Template                      | [->](https://github.com/block-foundation/solidity-template) | [->](https://github.com/block-foundation/teal-template) |
| Architectural Design          | [->](https://github.com/block-foundation/solidity-architectural-design) | [->](https://github.com/block-foundation/teal-architectural-design) |
| Architecture Competition      | [->](https://github.com/block-foundation/solidity-architecture-competition) | [->](https://github.com/block-foundation/teal-architecture-competition) |
| Housing Cooporative           | [->](https://github.com/block-foundation/solidity-housing-cooperative) | [->](https://github.com/block-foundation/teal-housing-cooperative) |
| Land Registry                 | [->](https://github.com/block-foundation/solidity-land-registry) | [->](https://github.com/block-foundation/teal-land-registry) |
| Real-Estate Crowsfunding      | [->](https://github.com/block-foundation/solidity-real-estate-crowdfunding) | [->](https://github.com/block-foundation/teal-real-estate-crowdfunding) |
| Rent-to-Own                   | [->](https://github.com/block-foundation/solidity-rent-to-own) | [->](https://github.com/block-foundation/teal-rent-to-own) |
| Self-Owning Building          | [->](https://github.com/block-foundation/solidity-self-owning-building) | [->](https://github.com/block-foundation/teal-self-owning-building) |
| Smart Home                    | [->](https://github.com/block-foundation/solidity-smart-home) | [->](https://github.com/block-foundation/teal-smart-home) |

## Legal Information

### Copyright

Copyright 2023, [Stichting Block Foundation](https://www.blockfoundation.io). All rights reserved.

### License

Except as otherwise noted, the content in this repository is licensed under the
[Creative Commons Attribution 4.0 International (CC BY 4.0) License](https://creativecommons.org/licenses/by/4.0/), and
code samples are licensed under the [Apache 2.0 License](http://www.apache.org/licenses/LICENSE-2.0).

Also see [LICENSE](https://github.com/block-foundation/community/blob/master/LICENSE) and [LICENSE-CODE](https://github.com/block-foundation/community/blob/master/LICENSE-CODE).

### Warning

**Please note that this code should be audited by a professional smart-contract auditor before being used in a production environment as it is a simplified example and may not cover all potential security vulnerabilities.**

### Disclaimer

**THIS SOFTWARE IS PROVIDED AS IS WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING ANY IMPLIED WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE, MERCHANTABILITY, OR NON-INFRINGEMENT.**
