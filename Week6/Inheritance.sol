// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

contract Parent {
    function testPublic() public pure virtual returns(string memory) {
        return "Parent_Public";
    }

    function testExternal() external pure virtual returns(string memory) {
        return "Parent_External";
    }

    function testInternal() internal pure virtual returns(string memory) {
        return "Parent_Internal";
    }

    // 因為不能被 override，所以不能加 virtual，會錯
    function testPrivate() private pure returns(string memory) {
        return "Parent_Private";
    }

    // 測試呼叫內部 function
    function testCall() public view {
        testPublic();
        // testExternal(); // 會說不認得 testExternal() 這個 function，要改成下列方式呼叫
        this.testExternal();
        testInternal();
        testPrivate();
    }
}

// 測試繼承後可否 Override
contract ChildOverrideParent is Parent {
    function testPublic() public pure override returns(string memory) {
        return "Child_Public";
    }

    function testExternal() public pure override returns(string memory) {
        return "Child_External";
    }

    function testInternal() internal pure override returns(string memory) {
        return "Child_Internal";
    }

    // 不能 override
    // function testPrivate() private pure override returns(string memory) {
    //     return "Child_Private";
    // }

    function callParent() public pure returns(string memory) {
        return super.testPublic();
    }
}

// 測試繼承後可否呼叫 Parent
contract ChildCallParent is Parent {
    function callParent() public view {
        testPublic();
        // testExternal(); // 會說不認得 testExternal() 這個 function，要改成下列方式呼叫
        this.testExternal();
        testInternal();
        // testPrivate(); // 不行呼叫，會說找不到
    }
}
