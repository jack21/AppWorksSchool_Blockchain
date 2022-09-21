// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract EthWallet {
    address payable owner;
    
    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
    }

    function withdraw(uint _amount) external {
        require(msg.sender == owner, "not owner");
        owner.transfer(_amount);
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }
}
