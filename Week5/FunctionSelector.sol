// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract FunctionSelector {
    function encodeWithSignature() external pure returns(bytes memory) {
        return abi.encodeWithSignature("sum(uint256,uint256)");
    }

    function encodeWithSignatureManual() external pure returns(bytes4) {
        return bytes4(keccak256(bytes("sum(uint256,uint256)")));
    }

    function encodeFunctionSelector() external pure returns(bytes4) {
        // return bytes4(abi.encodeWithSignature("AppWorks(bool,uint256[],address,string)"));
        return bytes4(keccak256(bytes("AppWorks(bool,uint256[],address,string)")));
    }
}

