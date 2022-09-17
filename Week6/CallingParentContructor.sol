// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.16;

// 爸爸
contract Father {
    event FatherLog(string, string);

    constructor(string memory name) {
        emit FatherLog("Fathor Constructor", name);
    }
}

// 媽媽
contract Mother {
    event MotherLog(string, string);

    constructor(string memory name) {
        emit MotherLog("Mother Constructor", name);
    }
}

// 大寶：直接帶參數呼叫 Parent Constructor
contract Child1 is Father, Mother {
    constructor() Father("romeo") Mother("juliet") {
    }
}

// 二寶：動態參數呼叫 Parent Constructor
contract Child2 is Father, Mother {
    constructor(string memory fatherName, string memory motherName) Father(fatherName) Mother(motherName) {
    }
}

// 三寶：測試交換呼叫 Parent Constructor 的順序，看會不會改變執行的順序，結果是不變，一樣是 Father → Mother
contract Child3 is Father, Mother {
    constructor() Mother("juliet") Father("romeo") {
    }
}

// 四寶：測試交換呼叫 Parent Constructor 的順序，看會不會改變執行的順序，結果是不變，一樣是 Father → Mother
contract Child4 is Father, Mother {
    constructor(string memory fatherName, string memory motherName) Mother(motherName) Father(fatherName) {
    }
}

// 小寶：測試交換 Parent Constructor 的宣告順序，看會不會改變執行順序，結果會變，變成 Mother → Father
// 結論：Parent Constructor 的執行順序跟宣告順序有關
contract Child5 is Mother, Father {
    constructor() Mother("juliet") Father("romeo") {
    }
}


