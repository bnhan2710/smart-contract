pragma solidity ^0.8.0;

contract SimpleContract {
    uint public myNumber;
    address public owner;
    bool public paused = false;

    event NumberUpdated(uint newNumber);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Paused(bool isPaused);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    constructor() {
        owner = msg.sender;  // người deploy hợp đồng là chủ sở hữu
    }

    function setNumber(uint _newNumber) public onlyOwner whenNotPaused {
        myNumber = _newNumber;
        emit NumberUpdated(_newNumber);  
    }

    function getNumber() public view whenNotPaused returns (uint) {
        return myNumber;
    }

    // Chuyển quyền sở hữu
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "New owner cannot be the zero address");
        emit OwnershipTransferred(owner, _newOwner);
        owner = _newOwner;
    }

    // Dừng hoặc tiếp tục contract
    function togglePause() public onlyOwner {
        paused = !paused;
        emit Paused(paused);
    }

    // Hàm fallback nhận Ether
    receive() external payable {}

    fallback() external payable {}
}
