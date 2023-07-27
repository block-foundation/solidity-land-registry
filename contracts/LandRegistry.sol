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
    /// @param price The price handles selling land parcels.
    struct Land {
        address payable owner;
        string location;
        string parcelID;
        uint256 price;
    }


    // Mappings
    // ========================================================================

    /// @notice Keep track of all the lands
    mapping (string => Land) public lands;

    /// @notice Keep track of all the lands owned by a particular address
    mapping (address => string[]) public ownerToLands;


    // Events
    // ========================================================================

    /// @notice Land Registered Event
    /// @param owner The owner
    /// @param parcelID The parcelID
    event LandRegistered(
        address indexed owner,
        string parcelID
    );

    /// @notice Land Transferred Event
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

    /// @notice The onlyLandOwner modifier  ensures that only the owner of a
    /// land parcel can perform certain actions.
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

    /// @notice Register Land Function allows an address to register a new 
    /// parcel of land with its location and a unique parcel ID. Emits a 
    /// LandRegistered event when land is registered.
    /// @param _location The location of the parcel
    /// @param _parcelID The parcel of land
    /// @param _price The price of the parcel
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
        
        // Add the parcelID to the list of lands owned by the sender
        ownerToLands[msg.sender].push(_parcelID);

        // Emit the event
        emit LandRegistered(
            msg.sender,
            _parcelID
        );

    }

    /// @notice Transfer Land Function allows the current owner of a land
    /// parcel to transfer it to a new owner. Emits a LandTransferred event
    /// when land is transferred.
    /// @param _newOwner The new owner of the parcel
    /// @param _parcelID The parcel of land
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


    /// @notice Sell Land Function allows a landowner to sell their land to a
    /// buyer. This also involves the transfer of Ether from the buyer to the
    //  seller, representing the payment for the land.
    /// @param _buyer The buyer of the parcel
    /// @param _parcelID The parcel of land
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

    /// @notice Verify Land Function allows anyone to verify the details of a
    /// land parcel.
    /// @param _parcelID The parcel of land
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

    /// @notice listLandsByOwner Function to list all the lands owned by an address
    /// @param _owner The owner of land
    /// @return [_parcownerToLandselID] array
    function listLandsByOwner(
        address _owner
    ) public view returns (
        string[] memory
    ) {
        return ownerToLands[_owner];
    }

}
