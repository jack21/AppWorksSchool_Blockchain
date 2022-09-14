// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract Parent {
    function _public() public pure virtual returns(string memory) {
        return "Parent_Public";
    }

    function _external() external pure virtual returns(string memory) {
        return "Parent_External";
    }

    function _internal() internal pure virtual returns(string memory) {
        return "Parent_Internal";
    }

    // 因為不能 override，所以不能加 virtual，會錯
    function _private() private pure returns(string memory) {
        return "Parent_Private";
    }

    // 測試呼叫內部 function
    function callAll() public view {
        _public();
        // _external(); // 會說不認得 _external() 這個 function，要改成下列方式呼叫
        this._external();
        _internal();
        _private();
    }
}

// 測試繼承後可否 Override
contract ChildOverrideParent is Parent {
    function _public() public pure override returns(string memory) {
        return "Child_Public";
    }

    function _external() public pure override returns(string memory) {
        return "Child_External";
    }

    function _internal() internal pure override returns(string memory) {
        return "Child_Internal";
    }

    // 不能 override
    // function _private() private pure override returns(string memory) {
    //     return "Child_Private";
    // }
}

// 測試繼承後可否呼叫 Parent
contract ChildCallParent is Parent {
    function callParent() public view {
        _public();
        // _external(); // 會說不認得 _external() 這個 function，要改成下列方式呼叫
        this._external();
        _internal();
        // _private(); // 不行呼叫，會說找不到
    }
}
