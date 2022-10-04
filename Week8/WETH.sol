// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WETH is ERC20 {
    constructor() ERC20("JCOIN", "JackCoin") {}

    event Deposit(address indexed, uint256 amount);
    event Withdraw(address indexed, uint256 amount);

    // 避免 Warning，不然可以不用加
    receive() external payable {
        deposit();
    }

    fallback() external payable {
        deposit();
    }

    function deposit() public payable {
        _mint(msg.sender, msg.value);
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        _burn(msg.sender, _amount);
        (bool success, ) = msg.sender.call{value: _amount}("");
        if (success) {
            emit Withdraw(msg.sender, _amount);
        }
    }
}
