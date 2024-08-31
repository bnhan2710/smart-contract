// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageManager {

    SimpleStorage private simpleStorage;

    event StorageContractSet(address indexed storageContract);
    event DataUpdatedInStorage(uint256 newData);

    constructor(address simpleStorageAddress) {
        simpleStorage = SimpleStorage(simpleStorageAddress);
        emit StorageContractSet(simpleStorageAddress);
    }

    function updateStorage(uint256 newValue) public {
        simpleStorage.set(newValue);
        emit DataUpdatedInStorage(newValue);
    }

    function retrieveStorage() public view returns (uint256) {
        return simpleStorage.get();
    }

    function getStorageOwner() public view returns (address) {
        return simpleStorage.getOwner();
    }

    function changeStorageContract(address newStorageContract) public {
        simpleStorage = SimpleStorage(newStorageContract);
        emit StorageContractSet(newStorageContract);
    }
}
