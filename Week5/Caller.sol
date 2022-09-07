// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

error CallFailed();

contract Caller {
    // 呼叫另一個合約
    function call(address _to, uint a, uint b) external returns(bytes memory) {
        (bool success, bytes memory data) = _to.call(abi.encodeWithSignature("sum(uint256,uint256)", a, b));
        if(!success){
            revert CallFailed();
        }
        return data;
    }
}
