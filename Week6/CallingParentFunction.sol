// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

// 人類
contract Human {
    event Log(string);

    function say() public virtual {
        emit Log("Human say");
    }
}

// 爸爸
contract Father is Human {
    function say() public virtual override {
        emit Log("Father say");
    }
}

// 媽媽
contract Mother is Human {
    function say() public virtual override {
        emit Log("Mother say");
    }
}

// 大寶：直接呼叫 say() 時要指定 Father or Mother
//     （注意：如果只寫 say()，會呼叫到自己的 say()，導致無窮迴圈）
contract Child1 is Father, Mother {
    function say() public override(Father, Mother) {
        Father.say();
        Mother.say();
    }
}

// 二寶：呼叫 super.say()，會呼叫到 Mother.say()，以 contract 宣告時，"is" 最右邊的為主
contract Child2 is Father, Mother {
    function say() public override(Father, Mother) {
        super.say(); // Mother.say()
    }
}

// 三寶：呼叫 super.say()，即使交換 say() 後的 override 內的順序
//      還是會呼叫到 Mother.say()，一樣以 contract 宣告時，"is" 最右邊的為主
contract Child3 is Father, Mother {
    function say() public override(Mother, Father) {
        super.say(); // Mother.say()
    }
}

// 四寶：呼叫 super.say()，但有交換 contract 後的繼承順序，以 "is" 最右邊的為主
//      這次就會呼叫到 Father.say()
contract Child4 is Mother, Father {
    function say() public override(Father, Mother) {
        super.say(); // Father.say()
    }
}

// 小寶：測試繼承祖父合約跟父合約，呼叫 super.say()，結果一樣以 "is" 最右邊的為主，會呼叫到 Father.say()
//      當然也可以直接呼叫 Human.say()
contract Child5 is Human, Father {
    function say() public override(Human, Father) {
        super.say(); // Father.say()
        Human.say(); // Human.say()
    }
}





