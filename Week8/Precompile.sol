// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Precompile {
    function ecadd(uint ax, uint ay, uint bx, uint by) public returns (uint[2] memory output) {
        uint[4] memory input = [ax, ay, bx, by];
        assembly {
            // 呼叫 0x6 的 bn256add() precompile，實現橢圓曲線加法
            if iszero(call(not(0), 0x06, 0, input, 0x80, output, 0x40)) {
                revert(0, 0)
            }
        }
    }
}










