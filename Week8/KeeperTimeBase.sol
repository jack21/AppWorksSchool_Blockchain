// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract KeeperTimeBase {
    // 記錄被呼叫的次數
    uint256 public counter = 0;

    // 被呼叫時記錄 Event，這樣查合約可以看到呼叫記錄
    event Log(uint256 timestamp, uint256 counter);

    function timeBaseCallback() external {
        counter++; // 每被呼叫一次 +1
        emit Log(block.timestamp, counter++);
    }
}
