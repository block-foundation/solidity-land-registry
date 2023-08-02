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
 *  @file Test Script for LandRegistry Contract
 *
 *  This script tests the LandRegistry contract using Hardhat and ethers.js.
 * 
 *  The following functionalities are tested:
 *  1.  Registering land.
 *  2.  Transferring land (including an error case where a non-owner tries
 *      to transfer).
 *  3.  Selling land (including an error case where a non-owner tries to sell).
 *  4.  Verifying land (including an error case where an attempt is made to
 *      verify a non-registered land parcel).
 *
 *  @requires hardhat
 *  @requires ethers
 *  @requires chai
 */

 import { ethers } from "hardhat";
 import { expect } from "chai";
 
 describe("LandRegistry", function() {

    let LandRegistry;
    let landRegistry;
    let owner;
    let addr1;
    let addr2;
    
    // This runs before each test and deploys the contract to be tested
    beforeEach(async () => {
        LandRegistry = await ethers.getContractFactory("LandRegistry");
        [owner, addr1, addr2, _] = await ethers.getSigners();
        landRegistry = await LandRegistry.deploy();
        await landRegistry.deployed();
    });
    
    // Test case for land registration
    it("Should allow land registration", async function() {
        await landRegistry.registerLand(
            "Location 1",
            "Parcel 1",
            ethers.utils.parseEther("1")
        );
        const land = await landRegistry.verifyLand("Parcel 1");
    
        expect(land[0]).to.equal(owner.address);
        expect(land[1]).to.equal("Location 1");
        expect(land[2]).to.equal("Parcel 1");
        expect(land[3]).to.equal(ethers.utils.parseEther("1"));
    });
    
    // Test case for land transfer
    it("Should allow land transfer", async function() {
        await landRegistry.registerLand("Location 1", "Parcel 1", ethers.utils.parseEther("1"));
        await landRegistry.transferLand(addr1.address, "Parcel 1");
    
        const land = await landRegistry.verifyLand("Parcel 1");
    
        expect(land[0]).to.equal(addr1.address);
    });
    
    // Test case for an unsuccessful land transfer by a non-owner
    it("Should not allow non-owners to transfer land", async function() {
        await landRegistry.registerLand("Location 1", "Parcel 1", ethers.utils.parseEther("1"));
    
        await expect(landRegistry.connect(addr1).transferLand(addr2.address, "Parcel 1")).to.be.revertedWith("Only the current owner can perform this operation.");
    });
    
    // Test case for land selling
    it("Should allow land sell", async function() {
        await landRegistry.registerLand("Location 1", "Parcel 1", ethers.utils.parseEther("1"));
        
        // To simulate the process of selling land, we need to fund addr1 with enough Ether.
        await owner.sendTransaction({
        to: addr1.address,
        value: ethers.utils.parseEther("1")
        });
        
        await landRegistry.connect(addr1).sellLand(owner.address, "Parcel 1");
        
        const land = await landRegistry.verifyLand("Parcel 1");
        
        expect(land[0]).to.equal(owner.address);
    });
    
    // Test case for an unsuccessful land selling by a non-owner
    it("Should not allow non-owners to sell land", async function() {
        await landRegistry.registerLand("Location 1", "Parcel 1", ethers.utils.parseEther("1"));
    
        await expect(landRegistry.connect(addr1).sellLand(addr2.address, "Parcel 1")).to.be.revertedWith("Only the current owner can perform this operation.");
    });
    
    // Test case for verifying registered land
    it("Should verify land", async function() {
        await landRegistry.registerLand("Location 1", "Parcel 1", ethers.utils.parseEther("1"));
        const land = await landRegistry.verifyLand("Parcel 1");
    
        expect(land[0]).to.equal(owner.address);
        expect(land[1]).to.equal("Location 1");
        expect(land[2]).to.equal("Parcel 1");
        expect(land[3]).to.equal(ethers.utils.parseEther("1"));
    });
    
    // Test case for an unsuccessful land verification when land is not registered
    it("Should not verify non-registered land", async function() {
        await expect(landRegistry.verifyLand("Parcel 1")).to.be.revertedWith("This land parcel is not registered.");
    });

});
    