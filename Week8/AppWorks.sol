// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract AppWorks is ERC721, Ownable {
  using Strings for uint256;

  using Counters for Counters.Counter;
  Counters.Counter private _nextTokenId;

  uint256 public price = 0.01 ether;
  uint256 public constant maxSupply = 100;
 
  bool public mintActive = false;
  bool public earlyMintActive = false;
  bool public revealed = false;
  
  string public baseURI;
  bytes32 public merkleRoot;

  mapping(uint256 => string) private _tokenURIs;
  mapping(address => uint256) public addressMintedBalance;

  constructor() ERC721("AppWorks", "AW") {
 
  }

  // Public mint function - week 8
  function mint(uint256 _mintAmount) public payable {
    //Please make sure you check the following things:
    //Current state is available for Public Mint
    require(mintActive, "mint is not active");
    //Check how many NFTs are available to be minted
    require(_nextTokenId.current() + _mintAmount <= maxSupply, "too late");
    //Check user has sufficient funds
    require(_mintAmount > 0, "at lease 1 NFT");
    require(msg.value >= _mintAmount * price, "get out");
    // Mint
    for (uint i = 0; i < _mintAmount; i++) {
        uint tokenId = _nextTokenId.current();
        _safeMint(msg.sender, tokenId); // Mint
        _tokenURIs[tokenId] = tokenURI(tokenId); // Token URI
        _nextTokenId.increment();
    }
    // 將多餘的錢記錄下來
    uint balance = msg.value - (_mintAmount * price);
    addressMintedBalance[msg.sender] += balance;
  }
  
  // Implement totalSupply() Function to return current total NFT being minted - week 8
  function totalSupply() external pure returns(uint) {
    return maxSupply;
  }

  // Implement withdrawBalance() Function to withdraw funds from the contract - week 8
  function withdrawBalance() external {
    // 剩多少錢可以領
    uint balance = addressMintedBalance[msg.sender];
    if (balance > 0) {
      // 先設定成 0，以免 ReEntrancy  
      addressMintedBalance[msg.sender] = 0;
      (bool success, ) = payable(msg.sender).call{value: balance}("");
      // 如果失敗要把錢還回去
      if (!success) {
        addressMintedBalance[msg.sender] = balance;
      }
    }
  }

  // 第二種寫法，擋 ReEntrancy，但不知道跟第一種寫法哪一種好，上課再來問
  // function withdrawBalance2() external {
  //   // 剩多少錢可以領
  //   uint balance = addressMintedBalance[msg.sender];
  //   if (balance > 0) {
  //     (bool success, ) = payable(msg.sender).call{value: balance}("");
  //     // 靠 0.8 之後內建 SafeMath，如果被 ReEntrancy，下一行會 Revert
  //     addressMintedBalance[msg.sender] -= balance;
  //   }
  // }

  // Implement setPrice(price) Function to set the mint price - week 8
  function setPrice(uint _price) external onlyOwner {
    price = _price;
  }
 
  // Implement toggleMint() Function to toggle the public mint available or not - week 8
  function toggleMint() external onlyOwner {
    mintActive = !mintActive;
  }

  // Set mint per user limit to 10 and owner limit to 20 - Week 8

  // Implement toggleReveal() Function to toggle the blind box is revealed - week 9

  // Implement setBaseURI(newBaseURI) Function to set BaseURI - week 9

  // Function to return the base URI
  function _baseURI() internal view virtual override returns (string memory) {
    return baseURI;
  }

  // Early mint function for people on the whitelist - week 9
  function earlyMint(bytes32[] calldata _merkleProof, uint256 _mintAmount) public payable {
    //Please make sure you check the following things:
    //Current state is available for Early Mint
    //Check how many NFTs are available to be minted
    //Check user is in the whitelist - use merkle tree to validate
    //Check user has sufficient funds
  }
  
  // Implement toggleEarlyMint() Function to toggle the early mint available or not - week 9

  // Implement setMerkleRoot(merkleRoot) Function to set new merkle root - week 9

  // Let this contract can be upgradable, using openzepplin proxy library - week 10
  // Try to modify blind box images by using proxy
  
}
