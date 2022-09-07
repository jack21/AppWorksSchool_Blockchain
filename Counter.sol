// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract Counter {
    uint counter;

    // 加 1
    function inc() external {
        counter++;
    }

    // 減 1
    function dec() external {
        counter--;
    }

    // 取得計數器內容
    function getCount() external view returns(uint) {
        return counter;
    }
}
