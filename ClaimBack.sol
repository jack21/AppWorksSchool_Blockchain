// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// 練習 https://docs.google.com/presentation/d/1-pXrW4Qaes4ZWNXoAio7OnhzTwg-dhgx6cSHxWVALKk/edit#slide=id.g15081281f2e_0_2
contract ClaimBack {
    address constant CONTRACT = 0xd33C69361e00f01C3085ac77ab2fA13bE10376E8;
    
    constructor() payable{}

    function send() external payable {
        payable(CONTRACT).transfer(1000000000000000);
    }

    receive() external payable {
    }
    
    function claim() external returns(bytes memory) {
        (bool success, bytes memory data) = address(CONTRACT).call(abi.encodeWithSignature("clain(uint256)", 0));
        if (!success) {
            revert();
        }
        return data;
    }
}
