// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

contract Delegate {
    address public owner;

    constructor(address _owner) public {
        owner = _owner;
    }

    function pwn() public {
        owner = msg.sender;
    }
}

contract Delegation {
    address public owner;
    Delegate delegate;
    event Log(address sender, address owner, bytes data);

    constructor(address _delegateAddress, address _owner) public {
        delegate = Delegate(_delegateAddress);
        owner = _owner;
    }

    fallback() external {
        (bool result, ) = address(delegate).delegatecall(msg.data);
        emit Log(msg.sender, owner, msg.data);
        if (result) {
            this;
        }
    }
}
