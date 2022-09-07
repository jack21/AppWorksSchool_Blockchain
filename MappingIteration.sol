// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract MappingIteration {
    mapping(address => uint) balances;
    mapping(address => bool) exists;
    address[] keys;

    // 設定 Key-Value
    function set(address _key, uint _value) external {
        balances[_key] = _value;
        if (!exists[_key]) {
            keys.push(_key);
            exists[_key] = true;
        }
    }

    // 取得 Mapping 長度
    function length() external view returns(uint) {
        return keys.length;
    }

    // Mapping 內第一個元素(有檢查 mapping 內是否有元素)
    function first() external view returns(uint) {
        require(keys.length > 0);
        return balances[keys[0]];
    }

    // Mapping 內最後一個元素(有檢查 mapping 內是否有元素)
    function last() external view returns(uint) {
        require(keys.length > 0);
        return balances[keys[keys.length - 1]];
    }

    // 取 Mapping 內指定的元素(有檢查 index 是否超過 mapping 長度)
    function get(uint _index) external view returns(uint) {
        require(keys.length > _index);
        return balances[keys[_index]];
    }
}
