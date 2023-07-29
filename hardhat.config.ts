// SPDX-License-Identifier: Apache-2.0


// Copyright 2023 Stichting Block Foundation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


/**
 * @file Hardhat configuration for LandRegistry Contract
 *
 * This script sets up the Hardhat configuration for the LandRegistry contract.
 * 
 * Configuration includes:
 * - Solidity compiler version.
 * - Network setup for local and Infura-based development.
 * - Paths for artifacts and cache.
 *
 * @requires hardhat
 * @requires @nomiclabs/hardhat-waffle
 * @requires @nomiclabs/hardhat-ethers
 * @requires dotenv
 */


 import { HardhatUserConfig } from "hardhat/config";
 import "@nomiclabs/hardhat-waffle";
 import "@nomiclabs/hardhat-ethers";
 import * as dotenv from 'dotenv';
 
 
 dotenv.config();
 
 const INFURA_PROJECT_ID = process.env.INFURA_PROJECT_ID;
 const DEPLOYER_PRIVATE_KEY = process.env.DEPLOYER_PRIVATE_KEY;
 
 const config: HardhatUserConfig = {
   solidity: "0.8.9",
   networks: {
     hardhat: {
       chainId: 1337,
     },
     rinkeby: {
       url: `https://rinkeby.infura.io/v3/${INFURA_PROJECT_ID}`,
       accounts: [`0x${DEPLOYER_PRIVATE_KEY}`],
     },
   },
   paths: {
     artifacts: "./artifacts",
     cache: "./cache",
     sources: "./contracts",
     tests: "./test",
   },
 };
 
 export default config;
 
 
 
 
// import { HardhatUserConfig } from "hardhat/config";
// import "@nomicfoundation/hardhat-toolbox";

// const config: HardhatUserConfig = {
//   solidity: "0.8.19",
// };

// export default config;
