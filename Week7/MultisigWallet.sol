// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

// 管理員的管理邏輯放在這個合約內
contract OwnerManager {
    uint16 public ownerCount; // 管理員人數
    uint16 public requireCount = 1; // 至少需要簽署的人數
    mapping(address => bool) public owners;

    // 把呼叫者塞進去管理員清單中
    constructor() {
        _addOwner(msg.sender);
    }

    // 確認呼叫者是管理員清單中的地址
    modifier onlyOwner() {
        require(owners[msg.sender], "not owner");
        _;
    }

    // 判斷是否為管理員
    function isOwner(address _addr) public view returns (bool) {
        return owners[_addr];
    }

    // 新增管理員
    function addOwner(address _newOwner) external onlyOwner {
        _addOwner(_newOwner);
    }

    // 新增管理員
    // 1. 因為 外部跟 Constructor 都要呼叫，所以搬出來成 internal
    // 2. 因為 Constructor 呼叫時，owners 還沒有東西，所以不能上 onlyOwner modifier
    function _addOwner(address newOwner) internal {
        require(newOwner != address(0), "zero address"); // 檢查：不能 Zero Address
        if (!owners[newOwner]) {
            owners[newOwner] = true;
            ownerCount++;
        }
    }

    // 刪除管理員
    function deleteOwner(address _ownerAddr) external onlyOwner {
        require(_ownerAddr != address(0), "zero address"); // 檢查：不能 Zero Address
        if (owners[_ownerAddr]) {
            require(
                ownerCount - 1 >= requireCount,
                "owner count < require count after delete"
            ); // 檢查：刪除管理員後不能少於需要簽署的人數
            require(ownerCount > 1, "at least 1 owner"); // 檢查：刪除管理員後至少需要剩下一個管理員
            owners[_ownerAddr] = false;
            ownerCount--;
        }
    }

    // 設定至少需要簽署的人數
    function setRequireCount(uint16 _count) external onlyOwner {
        require(_count > 0, "require count must > 0"); // 檢查：至少需要 1 人簽署
        requireCount = _count;
    }
}

// 簽署的邏輯放在這個合約內
contract MultisigWallet is OwnerManager {
    // 交易資料
    struct Transaction {
        address to;
        uint value;
        bytes data;
        bool isExecute;
        uint16 confirmCount;
    }
    Transaction[] public trans;
    // 記錄 transaction_id => owner => bool，用意是看 owner 確認過沒
    mapping(uint => mapping(address => bool)) public isConfirmed;

    // 確認 txId 要存在
    modifier txExist(uint txId) {
        require(txId >= trans.length, "invalid txId");
        _;
    }

    // 確認 txId 還沒被執行過
    modifier txNotExecute(uint txId) {
        require(!trans[txId - 1].isExecute, "transaction executed");
        _;
    }

    // 送入欲執行的交易，回傳 txId（1-base）
    function submitTransaction(address _to, uint _value, bytes memory _data) external onlyOwner returns(uint) {
        Transaction memory tran = Transaction(_to, _value, _data, false, 1);
        trans.push(tran);
        return trans.length;
    }

    // 確認交易
    function confirmTransaction(uint txId) external onlyOwner txExist(txId) txNotExecute(txId) {
        require(!isConfirmed[txId][msg.sender], "confirmed");
        Transaction storage tran = trans[txId - 1];
        tran.confirmCount += 1;
        isConfirmed[txId][msg.sender] = true;
    }

    // 執行交易
    function executeTransaction(uint txId) external onlyOwner txExist(txId) txNotExecute(txId) returns(bool) {
        Transaction storage tran = trans[txId - 1];
        require(tran.confirmCount >= requireCount, "transaction not confirm totally");
        (bool success,) = tran.to.call{value: tran.value}(tran.data);
        return success;
    }

    // 撤回確認
    function revokeTransaction(uint txId) external onlyOwner txExist(txId) txNotExecute(txId) returns(bool) {
        Transaction storage tran = trans[txId - 1];
        require(tran.confirmCount >= requireCount, "transaction not confirm totally");
        (bool success,) = tran.to.call{value: tran.value}(tran.data);
        return success;
    }
}
