// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract EncodeDecode {
    // Encode：丟參數值進去，回傳 encode 後的內容
    function encode(string memory name, uint score) external pure returns(bytes memory) {
        return abi.encode(name, score);
    }

    // Encode：丟參數值進去，回傳 encode 後的內容
    function encodeWithSignature() external pure returns(bytes memory) {
        return abi.encodeWithSignature("test(bool)", true);
    }

    // Decode：丟 encode 後的值及參數形態，回傳編碼前的參數值
    function decode(bytes calldata data) external pure returns(string memory, uint) {
        return abi.decode(data, (string, uint));
    }
}







