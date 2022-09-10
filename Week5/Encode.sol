// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Encode {
    function encode(string memory s1, string memory s2) external pure returns(bytes memory) {
        return abi.encode(s1, s2);
    }

    function encodeBytes(bytes memory b) external pure returns(bytes memory) {
        return abi.encode(b);
    }

    function encodePacked(string memory s1, string memory s2) external pure returns(bytes memory) {
        return abi.encodePacked(s1, s2);
    }
}

