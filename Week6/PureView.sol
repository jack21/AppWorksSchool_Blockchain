// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract PureView {
    uint i = 0;

    function _pure() public pure returns(uint) {
        // pure 無法讀取 state variable
        // return i; 

        // 只能讀取 local variable
        uint num = 3;
        return num * 2;
    }

    function _view() public view returns(uint) {
        // view 可以讀取 state variable，但無法寫入
        // i = 1;
        return i;
    }

    // 不加 view or pure，可以讀取、寫入 state variable
    function _() public returns(uint) {
        i = 1;
        return i;
    }
}