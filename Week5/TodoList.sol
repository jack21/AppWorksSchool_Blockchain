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
    function updateTodo(uint _index, string calldata _text) external  {
        require(_index < todoList.length);
        todoList[_index].text = _text;
    }

    // 勾選或反勾選 Todo
    function toggleTodo(uint _index) external  {
        require(_index < todoList.length);
        todoList[_index].isCheck = !todoList[_index].isCheck;
    }

    // 取得 Todo
    function getTodo(uint _index) external view returns(Todo memory) {
        return todoList[_index];
    }
}

