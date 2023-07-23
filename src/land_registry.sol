pragma solidity ^0.8.6;

contract LandRegistry {
    struct Land {
        address payable owner;
        string location;
        string parcelID;
        uint256 price;
    }

    mapping (string => Land) public lands;
    
    // Event logging
    event LandRegistered(address indexed owner, string parcelID);
    event LandTransferred(address indexed oldOwner, address indexed newOwner, string parcelID);

    modifier onlyLandOwner(string memory _parcelID) {
        require(lands[_parcelID].owner == msg.sender, "Only the current owner can perform this operation.");
        _;
    }

    function registerLand(string memory _location, string memory _parcelID, uint256 _price) public {
        // Check if the land parcel is already registered
        require(lands[_parcelID].owner == address(0), "This land parcel is already registered.");

        // Create a new Land struct and store it in the lands mapping
        lands[_parcelID] = Land(payable(msg.sender), _location, _parcelID, _price);
        
        // Emit the event
        emit LandRegistered(msg.sender, _parcelID);
    }

    function transferLand(address payable _newOwner, string memory _parcelID) public onlyLandOwner(_parcelID) {
        // Transfer the land to the new owner
        address oldOwner = lands[_parcelID].owner;
        lands[_parcelID].owner = _newOwner;
        
        // Emit the event
        emit LandTransferred(oldOwner, _newOwner, _parcelID);
    }

    function sellLand(address payable _buyer, string memory _parcelID) public onlyLandOwner(_parcelID) {
        // Transfer the land to the new owner
        address oldOwner = lands[_parcelID].owner;
        lands[_parcelID].owner = _buyer;

        // Transfer the funds to the previous owner
        lands[_parcelID].owner.transfer(lands[_parcelID].price);

        // Emit the event
        emit LandTransferred(oldOwner, _buyer, _parcelID);
    }

    function verifyLand(string memory _parcelID) public view returns (address, string memory, string memory, uint256) {
        // Check if the land parcel is registered
        require(lands[_parcelID].owner != address(0), "This land parcel is not registered.");

        // Return the land details
        return (lands[_parcelID].owner, lands[_parcelID].location, lands[_parcelID].parcelID, lands[_parcelID].price);
    }
}
