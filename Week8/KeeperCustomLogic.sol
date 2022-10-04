// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AutomationCompatibleInterface.sol";
import "@chainlink/contracts/src/v0.8/AutomationCompatible.sol";

contract KeeperCustomLogic is AutomationCompatible {
    uint256 public counter = 0; // 記錄被呼叫的次數
    uint256 public immutable interval; // 每隔幾秒鐘允許被呼叫(Deploy 時是 60 秒)
    uint256 public lastTimeStamp; // 最後一次

    event CheckLog(uint256 timestamp, uint256 counter); // 檢查時會記錄的 Event
    event PerformLog(uint256 timestamp, uint256 counter); // 執行時會記錄的 Event

    constructor(uint256 updateInterval) {
        interval = updateInterval;
        lastTimeStamp = block.timestamp;
    }

    function checkUpkeep(bytes calldata)
        external
        override
        returns (bool upkeepNeeded, bytes memory performData)
    {
        // 距離上次執行超過指定的 interval 秒數才允許執行
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
        emit CheckLog(block.timestamp, counter);
    }

    function performUpkeep(bytes calldata performData) external override {
        // 重要：需要再檢查一次可不可以執行，因為此 function 是 external，誰都可以呼叫
        if ((block.timestamp - lastTimeStamp) > interval) {
            lastTimeStamp = block.timestamp;
            counter++; // 被呼叫次數 +1
            emit PerformLog(block.timestamp, counter);
        }
    }
}
