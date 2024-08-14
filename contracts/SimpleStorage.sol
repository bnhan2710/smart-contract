// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleStorage {

    uint256 private storedData;


    event DataChanged(uint256 newData);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    address private owner;
    
    constructor() {
        owner = msg.sender;
    }

    function set(uint256 x) public onlyOwner {
        storedData = x;
        emit DataChanged(x); 
    }

    function get() public view returns (uint256) {
        return storedData;
    }

    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function getOwner() public view returns (address) {
        return owner;
    }
}
