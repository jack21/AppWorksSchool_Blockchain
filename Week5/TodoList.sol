// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract TodoList {
    struct Todo {
        string text;
        bool isCheck;
    }
    Todo[] todoList;

    // 新增一筆 Todo
    function createTodo(string calldata _text) external {
        todoList.push(Todo(_text, false));
    }

    // 更新 Todo 的內容
    function updateTodo(uint _index, string calldata _text) external {
        require(_index < todoList.length);
        todoList[_index].text = _text;
    }

    // 刪除某個 Todo（用到 Array-1 的概念）
    function deleteTodo(uint _index) external {
        require(_index < todoList.length);
        // 從指定要移除的 index 開始 loop，複製後一個元素的內容值
        for (uint i = _index; i < todoList.length - 1; i++) {
            todoList[i] = todoList[i+1];
        }
        // 移除 array 內最後一個元素
        todoList.pop();
    }

    // 勾選或反勾選 Todo
    function toggleTodo(uint _index) external {
        require(_index < todoList.length);
        todoList[_index].isCheck = !todoList[_index].isCheck;
    }

    // 取得 Todo
    function getTodo(uint _index) external view returns(Todo memory) {
        return todoList[_index];
    }
}



