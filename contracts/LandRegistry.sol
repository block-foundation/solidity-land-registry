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


pragma solidity ^0.8.9;


// ============================================================================
// Contracts
// ============================================================================

/// @title Land Registry Contract
/// @author Lars Bastiaan van Vianen
/// @notice You can use this contract for only the most basic simulation
/// @dev Alpha version
/// @custom:experimental This is an experimental contract.
contract LandRegistry {


    // Structs
    // ========================================================================

    /// @notice Land Struct
    /// @param owner The owner
    /// @param location The location
    /// @param parcelID The parcelID
    /// @param price The price
    struct Land {
        address payable owner;
        string location;
        string parcelID;
        uint256 price;
    }


    // Mappings
    // ========================================================================

    /// @notice 
    mapping (string => Land) public lands;


    // Events
    // ========================================================================

    /// @notice LandRegistered Event
    /// @param owner The owner
    /// @param parcelID The parcelID
    event LandRegistered(
        address indexed owner,
        string parcelID
    );

    /// @notice LandTransferred Event
    /// @param oldOwner The oldOwner
    /// @param newOwner The newOwner
    /// @param parcelID The parcelID
    event LandTransferred(
        address indexed oldOwner,
        address indexed newOwner,
        string parcelID
    );


    // Modifiers
    // ========================================================================

    /// @notice onlyLandOwner Modifier
    /// @param _parcelID The _parcelID
    modifier onlyLandOwner(
        string memory _parcelID
    ) {
        require(
            lands[_parcelID].owner == msg.sender,
            "Only the current owner can perform this operation."
        );
        _;
    }


    // Methods
    // ========================================================================

    /// @notice Register Land
    /// @param _location The location
    /// @param _parcelID The parcelID
    /// @param _price The price
    function registerLand(
        string memory _location,
        string memory _parcelID,
        uint256 _price
    ) public {

        // Check if the land parcel is already registered
        require(
            lands[_parcelID].owner == address(0),
            "This land parcel is already registered."
        );

        // Create a new Land struct and store it in the lands mapping
        lands[_parcelID] = Land(
            payable(msg.sender),
            _location,
            _parcelID,
            _price
        );
        
        // Emit the event
        emit LandRegistered(
            msg.sender,
            _parcelID
        );

    }

    /// @notice Transfer Land
    /// @param _newOwner The new owner
    /// @param _parcelID The parcelID
    function transferLand(
        address payable _newOwner,
        string memory _parcelID
    ) public onlyLandOwner(_parcelID) {

        // Transfer the land to the new owner
        address oldOwner = lands[_parcelID].owner;
        lands[_parcelID].owner = _newOwner;
        
        // Emit the event
        emit LandTransferred(oldOwner, _newOwner, _parcelID);

    }

    /// @notice Sell Land
    /// @param _buyer The buyer
    /// @param _parcelID The parcelID
    function sellLand(
        address payable _buyer,
        string memory _parcelID
    ) public onlyLandOwner(_parcelID) {

        // Transfer the land to the new owner
        address oldOwner = lands[_parcelID].owner;
        lands[_parcelID].owner = _buyer;

        // Transfer the funds to the previous owner
        lands[_parcelID].owner.transfer(lands[_parcelID].price);

        // Emit the event
        emit LandTransferred(oldOwner, _buyer, _parcelID);

    }

    /// @notice Verify Land
    /// @param _parcelID The parcelID
    /// @return [_parcelID] array
    function verifyLand(
        string memory _parcelID
    ) public view returns (
        address,
        string memory,
        string memory,
        uint256
    ) {

        // Check if the land parcel is registered
        require(
            lands[_parcelID].owner != address(0),
            "This land parcel is not registered."
        );

        // Return the land details
        return (
            lands[_parcelID].owner,
            lands[_parcelID].location,
            lands[_parcelID].parcelID,
            lands[_parcelID].price
        );

    }

}
