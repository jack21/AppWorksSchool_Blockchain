// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

error CallFailed();

contract ICallee{
    function sum(uint a, uint b) external returns(uint) {}
}

contract Caller {
    // 呼叫另一個合約
    function call(address _to, uint a, uint b) external returns(uint) {
        uint result = ICallee(_to).sum(a, b);
        return result;
    }
}
