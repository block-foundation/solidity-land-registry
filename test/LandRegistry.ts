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


import {
    time,
    loadFixture,
  } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
// const { expect } = require("chai");

  
const LandRegistry = artifacts.require("LandRegistry");


contract(
    "LandRegistry",
    function(accounts) {

    let landRegistry;
    const [alice, bob] = accounts;

    beforeEach(async function() {
        landRegistry = await LandRegistry.new({ from: alice });
    });

    it("allows land registration", async function() {
        await landRegistry.registerLand("Moon", "Parcel1", 100, { from: alice });

        const land = await landRegistry.verifyLand("Parcel1");
        expect(land[0]).to.equal(alice);
        expect(land[1]).to.equal("Moon");
        expect(land[2]).to.equal("Parcel1");
        expect(land[3].toNumber()).to.equal(100);
    });

    it("allows land transfer", async function() {
        await landRegistry.registerLand("Mars", "Parcel2", 200, { from: alice });
        await landRegistry.transferLand(bob, "Parcel2", { from: alice });

        const land = await landRegistry.verifyLand("Parcel2");
        expect(land[0]).to.equal(bob);
    });

    it("prevents non-owners from transferring land", async function() {
        await landRegistry.registerLand("Jupiter", "Parcel3", 300, { from: alice });

        try {
            await landRegistry.transferLand(bob, "Parcel3", { from: bob });
            assert.fail("Expected revert not received");
        } catch (error) {
            const revertFound = error.message.search('revert') >= 0;
            assert(revertFound, `Expected "revert", got ${error} instead`);
        }
    });

    it("allows land selling", async function() {
        await landRegistry.registerLand("Saturn", "Parcel4", 400, { from: alice });
        await landRegistry.sellLand(bob, "Parcel4", { from: alice, value: 400 });

        const land = await landRegistry.verifyLand("Parcel4");
        expect(land[0]).to.equal(bob);
    });
});
