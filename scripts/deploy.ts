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
 * @file Deploy Script for LandRegistry Contract
 * 
 * This script deploys the LandRegistry contract to the configured Ethereum
 * network using Hardhat and ethers.js.
 *
 * Before running the script, make sure you have correctly configured your
 * Hardhat network settings, and the contract has been compiled with
 * the `npx hardhat compile` command.
 *
 * After deployment, the script logs the address at which the contract
 * is deployed.
 *
 * @requires hardhat
 * @requires ethers
 */


 import { ethers, upgrades } from "hardhat";


 /**
  * @main
  * 
  * The main function deploys the LandRegistry contract.
  *
  * - Fetches the ContractFactory for the LandRegistry contract using ethers.js
  * - Deploys the contract
  * - Logs the contract address
  *
  * @returns {Promise<void>} No return value
  */
 async function main() {

    const LandRegistry = await ethers.getContractFactory("LandRegistry");
    
    // In case of upgradable contracts, use the following line instead
    // const instance = await upgrades.deployProxy(LandRegistry, ["arg1", "arg2"]);
    
    const instance = await LandRegistry.deploy();
    
    await instance.deployed();
    
    console.log("LandRegistry deployed to:", instance.address);

}


/**
 * @callback main
 *
 * Calls the main function and handles any errors.
 * If successful, exits with status 0. 
 * If an error occurs, logs the error and exits with status 1.
 */
main()
.then(() => process.exit(0))
.catch(
    (error) => {
        console.error(error);
        process.exit(1);
    }
);
