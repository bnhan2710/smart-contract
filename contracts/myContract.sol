
pragma solidity ^0.8.0;

contract SimpleContract {

    uint public myNumber;

    event NumberUpdated(uint newNumber);

    function setNumber(uint _newNumber) public {
        myNumber = _newNumber;
        emit NumberUpdated(_newNumber);  
    }

    function getNumber() public view returns (uint) {
        return myNumber;
    }
}
