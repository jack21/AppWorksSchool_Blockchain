// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.17;

import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";

contract Random is VRFConsumerBaseV2 {
  VRFCoordinatorV2Interface COORDINATOR;

  // Chainlink 的訂閱者 ID，在 Chainlink 創立 Subscription 後可以看到
  uint64 s_subscriptionId = 2460;

  // 不同網路有不同的合約地址，參考 https://docs.chain.link/docs/vrf-contracts/#configurations
  address vrfCoordinator = 0x2Ca8E0C643bDe4C2E08ab1fA0da3401AdAD7734D;

  // 根據自己的需求選擇所需的 Gas Fee，參考 https://docs.chain.link/docs/vrf-contracts/#configurations
  bytes32 keyHash = 0x79d3d8832d904592c0bf9818b621522c988bb8b0c05cdc3b15aea1b6e8db0c15;

  // 當 Chainlink VRF 產生完隨機數後會呼叫 fulfillRandomWords 這個 callback
  // 每產生一組隨機數通常要 20000，但這邊也要包含到你的其它邏輯，所以這邊可以根據所需來設定
  uint32 callbackGasLimit = 100000;

  // 要幾個節點驗證過後才進行 callback ，越高越安全，這個值在要根據每個合約規定的 Minimum 和 Maximum 來設定
  uint16 requestConfirmations = 3;

  uint256 public s_requestId;
  address s_owner;

  event RandomLog (
    uint requestId,
    uint[] randoms
  );

  constructor() VRFConsumerBaseV2(vrfCoordinator) {
    COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
    s_owner = msg.sender;
  }

  modifier onlyOwner() {
    require(msg.sender == s_owner);
    _;
  }

  // 最簡單的取亂數方式，從鏈上資訊產生亂數
  function getRandomFromBlock(uint number) external view returns(uint) {
    return uint(keccak256(abi.encodePacked(block.timestamp, block.difficulty, msg.sender))) % number;
  }

  // 對 Chainlink 發出取得隨機數的請求
  function requestRandomWords() external onlyOwner {
    s_requestId = COORDINATOR.requestRandomWords(
      keyHash,
      s_subscriptionId,
      requestConfirmations,
      callbackGasLimit,
      3 // 一次取得幾組隨機數
    );
  }

  // Chainlink callback
  function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
    emit RandomLog(requestId, randomWords);
  }
}

