// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract SimpleStorage {
    string text;

    function set(string calldata _text) external {
        text = _text;
    }

    function get() external view returns(string memory) {
        return text;
    }
}
