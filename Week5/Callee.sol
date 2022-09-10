// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Callee {
    // 記錄 msg.data & msg.sender & tx.origin
    event Log(bytes data, address indexed sender, address indexed txOrigin);
    
    // 計算總和後回傳
    function sum(uint a, uint b) external returns(uint) {
        emit Log(msg.data, msg.sender, tx.origin);
        return a + b;
    }
}


