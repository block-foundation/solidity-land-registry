// SPDX-License-Identifier: MIT

pragma solidity ^0.8.6;

/**
 * Land Registry Contract
 * @dev 
 */
contract LandRegistry {

    /**
     * Land
     * @dev 
     * @param owner The owner
     * @param location The location
     * @param parcelID The parcelID
     * @param price The price
     */
    struct Land {
        address payable owner;
        string location;
        string parcelID;
        uint256 price;
    }


    // Mapping
    // ========================================================================

    mapping (string => Land) public lands;


    // Event logging
    // ========================================================================

    event LandRegistered(
        address indexed owner,
        string parcelID
    );

    event LandTransferred(
        address indexed oldOwner,
        address indexed newOwner,
        string parcelID
    );


    // Modifiers
    // ========================================================================

    modifier onlyLandOwner(
        string memory _parcelID
    ) {
        require(
            lands[_parcelID].owner == msg.sender,
            "Only the current owner can perform this operation."
        );
        _;
    }


    // Functionality
    // ========================================================================

    /**
    * Register Land
     * @dev 
     * @param _location The location
     * @param _parcelID The parcelID
     * @param _price The price
     */
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

    /**
     * Transfer Land
     * @dev 
     * @param _newOwner The new owner
     * @param _parcelID The parcelID
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
     * Sell Land
     * @dev 
     * @param _buyer The buyer
     * @param _parcelID The parcelID
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
     * Verify Land
     * @dev 
     * @param _parcelID The parcelID
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

}
