// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract E10_ReEntrancy {
    address payable TARGET = payable(0x7155807a967852Be190eb1591776D9e41ED48e14);

    constructor() payable {
    }

    function selfDestruct() external {
        selfdestruct(TARGET);
    }
}

