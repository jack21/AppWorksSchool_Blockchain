// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract PiggyBank {
    address payable owner;
    
    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
    }

    function withdraw() external {
        require(msg.sender == owner, "not owner");
        selfdestruct(owner);
    }
}
