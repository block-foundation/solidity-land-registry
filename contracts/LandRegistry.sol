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

    /// @title Land Struct
    /// @dev This struct encapsulates all the data related to a parcel of land.
    /// @notice The data includes information about the owner, the location, the parcelID, and the price.
    /// @param owner An Ethereum address representing the owner of the land parcel. This address must be payable to handle transfers of Ether during transactions.
    /// @param location A string representing the geographical location of the land parcel. It can be in any format, such as coordinates or a simple description, but consistency is advised for easier tracking.
    /// @param parcelID A unique string that serves as the identifier for the land parcel. It is used as the key in the mapping of lands in the LandRegistry contract.
    /// @param price A uint256 value representing the price of the land parcel in wei. This field is used in transactions where land parcels are bought and sold.
    struct Land {
        address payable owner;
        string location;
        string parcelID;
        uint256 price;
        // bool isRegistered;  // Uncomment this if you want to include a flag indicating whether a parcel of land is registered or not.
    }


    // Mappings
    // ========================================================================

    /// @notice This mapping keeps track of all the land parcels. 
    /// @dev It maps a unique parcel ID to a Land struct containing all details of the land parcel.
    mapping (string => Land) public lands;

    /// @notice This mapping is used to keep track of all the lands owned by a particular address. 
    /// @dev It maps an owner's address to an array of parcel IDs, allowing us to see all the lands owned by a particular address.
    mapping (address => string[]) public ownerToLands;


    // Events
    // ========================================================================

    /// LandRegistered Event
    /// @notice This event is emitted when a new land parcel is registered.
    /// @dev The event logs the owner's address and the parcel ID of the newly registered land.
    /// @param owner The owner's address.
    /// @param parcelID The unique parcel ID of the registered land parcel.
    event LandRegistered(
        address indexed owner,
        string parcelID
    );

    /// LandTransferred Event
    /// @notice This event is emitted when a land parcel is transferred from one owner to another.
    /// @dev The event logs the old owner's address, the new owner's address, and the parcel ID of the transferred land parcel.
    /// @param oldOwner The address of the previous owner.
    /// @param newOwner The address of the new owner.
    /// @param parcelID The unique parcel ID of the transferred land parcel.
    event LandTransferred(
        address indexed oldOwner,
        address indexed newOwner,
        string parcelID
    );



    // Modifiers
    // ========================================================================

    /// onlyLandOwner
    /// @notice This modifier is used to restrict access to only the current owner of a specific land parcel. 
    /// It's often used in functions that update or change the state of a land parcel. If the 
    /// function is invoked by an address that is not the current owner, it will throw an exception 
    /// and stop execution.
    /// @dev It checks if the message sender is the owner of the land parcel specified by _parcelID. 
    /// If it is not, the execution of the function will stop, and an error message will be thrown.
    /// @param _parcelID The unique identifier of a land parcel. It is used to look up the current 
    /// owner of the land in the 'lands' mapping.
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

    /// registerLand
    /// @notice This function allows an Ethereum address to register a new parcel of land in the contract. 
    /// The parcel's location, unique parcel ID, and price are all required to perform this operation. 
    /// Once the land is successfully registered, a LandRegistered event will be emitted, notifying all 
    /// contract participants of the newly registered land.
    /// @dev This function has a protection mechanism built in to prevent duplicate registration of the 
    /// same parcel of land. If an attempt is made to register a parcel that has already been registered, 
    /// the function will throw an exception and halt execution.
    /// @param _location A string containing the geographical location of the land parcel. 
    /// This could be a description of the land's physical location, coordinates, or any other 
    /// identifying characteristic.
    /// @param _parcelID A unique identifier for the parcel of land. This ID is used to track the ownership 
    /// and other properties of the land within the contract.
    /// @param _price A uint256 that represents the price of the land in the smallest unit of the 
    /// currency used (such as wei for Ether). This price is set by the current owner of the land and 
    /// could be used in future land sale transactions.
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

    /**
    *   transferLand
    *   @notice This function allows the current owner of a parcel of land 
    *               to transfer their ownership rights to a new owner. This
    *               operation does not involve any transfer of funds or 
                    payment. Once the transfer is successful, a LandTransferred event will be emitted,
    *   notifying all contract participants of the change in ownership.
    *   @dev This function requires that the sender is the current owner of the land parcel. If not,
    *   the function will throw an exception and halt execution. The ownership check is performed 
    *   through the onlyLandOwner modifier.
    *   @param      _newOwner The Ethereum address of the new owner of the land parcel.
    *   @param      _parcelID A unique identifier for the parcel of land. This ID is used to find 
    *   the land parcel within the contract's storage and update its owner property.
    */
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


    /**
    *   sellLand
    *   @notice This function allows the current owner of a parcel of land to sell their 
    *   parcel to a buyer. This involves the transfer of ownership rights and the payment 
    *   of the purchase price in Ether from the buyer to the seller. Once the sale is successful, 
    *   a LandTransferred event will be emitted, notifying all contract participants of the 
    *   change in ownership.
    *   @dev This function requires that the sender is the current owner of the land parcel. If not,
    *   the function will throw an exception and halt execution. The ownership check is performed 
    *   through the onlyLandOwner modifier.
    *   @param _buyer The Ethereum address of the buyer of the land parcel. This address will 
    *   become the new owner of the land and will be responsible for transferring the purchase 
    *   price to the seller.
    *   @param _parcelID A unique identifier for the parcel of land. This ID is used to find 
    *   the land parcel within the contract's storage, update its owner property, and determine 
    *   the purchase price to be transferred.
    */
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

    /**
    *   verifyLand
    *   @notice This function allows anyone to verify the details of a specific parcel 
    *   of land. It fetches the ownership details, location, parcel ID, and price for the 
    *   given parcel ID from the contract's storage and returns it to the caller. If no 
    *   such parcel ID exists in the contract's storage, it will throw an exception and halt execution.
    *   @dev The function is read-only and does not modify the state of the contract. 
    *   @param _parcelID A unique identifier for the parcel of land. This ID is used to 
    *   find the land parcel within the contract's storage and return its details.
    *   @return owner The Ethereum address of the owner of the land parcel.
    *   @return location The geographical location of the land parcel.
    *   @return parcelID The unique identifier for the parcel of land.
    *   @return price The price of the land parcel in Ether.
    */
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

    /**
    *   listLandsByOwner
    *   @notice This function allows anyone to fetch a list of all parcel IDs owned 
    *   by a particular address. This can be useful to track all properties owned by 
    *   a single address and manage their land portfolio.
    *   @dev The function is read-only and does not modify the state of the contract. 
    *   @param _owner The Ethereum address of the owner whose lands are to be listed.
    *   @return parcelIDs An array of strings containing the unique identifiers for 
    *   each land parcel owned by the specified address.
    */
    function listLandsByOwner(
        address _owner
    ) public view returns (
        string[] memory
    ) {
        return ownerToLands[_owner];
    }

}
