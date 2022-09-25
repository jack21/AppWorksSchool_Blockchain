// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PercentCalculate {
    // 計算 x 的 3.5%
    function percent(uint256 x) external pure returns (uint256) {
        // 第一種寫法：Solidity 不支援浮點數運算，無法使用
        // return x * 0.035；

        // 第二種寫法：x 分別輸入 10000、1000、100
        // 到 100 就已經結果回傳 0 了，開始不準確
        // return (x/1000)*35;

        // 第三種寫法：x 分別輸入 10000、1000、100
        // 到 100 的時候回傳 3，在沒有浮點數的情況下，算是最接近正確答案
        return (x * 35) / 1000;
    }
}









