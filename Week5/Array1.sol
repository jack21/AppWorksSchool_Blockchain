// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Array1 {
    uint[] array = [1, 2, 3, 4, 5];

    // 取得 Array 內容(remove 後，驗證用)
    function getArray() external view returns(uint[] memory) {
        return array;
    }

    // 移除 array 內指定的 index（0-base）
    function remove(uint _index) external {
        require(_index < array.length);
        // 從指定要移除的 index 開始 loop，複製後一個元素的內容值
        for (uint i = _index; i < array.length - 1; i++) {
            array[i] = array[i+1];
        }
        // 移除 array 內最後一個元素
        array.pop();
    }
}

