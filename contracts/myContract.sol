pragma solidity ^0.8.0;

contract SimpleContract {
    uint public myNumber;
    address public owner;

    event NumberUpdated(uint newNumber);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can update the number");
        _;
    }

    constructor() {
        owner = msg.sender;  // người deploy hợp đồng là chủ sở hữu
    }

    function setNumber(uint _newNumber) public onlyOwner {
        myNumber = _newNumber;
        emit NumberUpdated(_newNumber);  
    }

    function getNumber() public view returns (uint) {
        return myNumber;
    }
}