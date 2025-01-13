pragma solidity ^0.8.0;

contract Contract {
    uint public myNumber;
    address public owner;
    bool public paused = false;

    event NumberUpdated(uint newNumber);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Paused(bool isPaused);

    // Modifier to allow only the owner to call certain functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    // Modifier to allow only when the contract is not paused
    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    // Constructor to initialize the owner as the address deploying the contract
    constructor() {
        owner = msg.sender;
    }

    // Function to set a new number, only allowed by the owner and when the contract is not paused
    function setNumber(uint _newNumber) public onlyOwner whenNotPaused {
        myNumber = _newNumber;
        emit NumberUpdated(_newNumber);  
    }

    // Function to get the current number, only available when the contract is not paused
    function getNumber() public view whenNotPaused returns (uint) {
        return myNumber;
    }

    // Function to transfer ownership to a new address
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "New owner cannot be the zero address");
        emit OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }

    // Function to pause or unpause the contract
    function togglePause() public onlyOwner {
        paused = !paused;
        emit Paused(paused);
    }

    // Fallback function to accept Ether (without specific function call)
    receive() external payable {}

    // Fallback function to accept Ether when no other function matches
    fallback() external payable {}
}
