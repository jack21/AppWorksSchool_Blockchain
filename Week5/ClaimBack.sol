// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

error ClaimError(bytes);

// 練習 https://docs.google.com/presentation/d/1-pXrW4Qaes4ZWNXoAio7OnhzTwg-dhgx6cSHxWVALKk/edit#slide=id.g15081281f2e_0_2
contract ClaimBack {
    address constant CONTRACT = payable(0xd33C69361e00f01C3085ac77ab2fA13bE10376E8);
    
    constructor() payable{}

    function transfer() external payable returns(bytes memory) {
        // payable(CONTRACT).transfer(1000000000000000);
        (bool success, bytes memory data) = CONTRACT.call{value:1000000000000000}("");
        if (!success) {
            revert();
        }
        return data;
    }

    receive() external payable {
    }
    
    function claim() external payable returns(bytes memory) {
        (bool success, bytes memory data) = CONTRACT.call(abi.encodeWithSignature("claim(uint256)", 1));
        if (!success) {
            revert ClaimError(data);
        }
        return data;
    }
}
