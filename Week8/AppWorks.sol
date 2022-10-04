// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract AppWorks is ERC721, Ownable, ReentrancyGuard {
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

    constructor() ERC721("AppWorks", "AW") {}

    // Public mint function - week 8
    // 以防萬一，直接加上 RentrancyGuard，雖然會多花一點 GAS，但起碼不會被打爆
    function mint(uint256 _mintAmount) public payable nonReentrant {
        //Please make sure you check the following things:
        //Current state is available for Public Mint
        require(mintActive, "mint is not active");
        //Check how many NFTs are available to be minted
        require(_nextTokenId.current() + _mintAmount <= maxSupply, "too late");
        //Check user has sufficient funds
        require(_mintAmount > 0, "at lease 1 NFT");
        uint256 _mintAmountPrice = _mintAmount * price;
        require(msg.value >= _mintAmountPrice, "get out");
        // owner 最多可以 mint 20 個、其他人最多可以 Mint 10 個
        require(isMintable(msg.sender, _mintAmount), "over mint count");
        // Mint
        for (uint256 i = 0; i < _mintAmount; i++) {
            uint256 tokenId = _nextTokenId.current();
            _safeMint(msg.sender, tokenId); // Mint
            _tokenURIs[tokenId] = tokenURI(tokenId); // Token URI
            _nextTokenId.increment(); // NFT ID + 1
        }
        // 記錄 Mint 了多少錢
        addressMintedBalance[msg.sender] += _mintAmount;
        // 將多餘的錢退還
        uint256 left = msg.value - _mintAmountPrice;
        if (left > 0) {
            msg.sender.call{ value: left }(""); // 還錢，發生錯誤就當賺到
        }
    }

    // Implement totalSupply() Function to return current total NFT being minted - week 8
    function totalSupply() external view returns (uint256) {
        return _nextTokenId.current();
    }

    // Implement withdrawBalance() Function to withdraw funds from the contract - week 8
    function withdrawBalance() external onlyOwner {
        (bool success, ) = msg.sender.call{ value: address(this).balance }("");
        if (!success) {
            revert();
        }
    }

    // Implement setPrice(price) Function to set the mint price - week 8
    function setPrice(uint256 _price) external onlyOwner {
        require(_price > 0, "price invalid");
        price = _price;
    }

    // Implement toggleMint() Function to toggle the public mint available or not - week 8
    function toggleMint() external onlyOwner {
        mintActive = !mintActive;
    }

    // Set mint per user limit to 10 and owner limit to 20 - Week 8
    function isMintable(address _who, uint256 _mintAmount) internal view returns (bool) {
        if (_who == owner()) {
            return balanceOf(_who) + _mintAmount <= 20; // Owner 可以 Mint 20 個 NFT
        } else {
            return balanceOf(_who) + _mintAmount <= 10; // 其他人可以 Mint 10 個 MNF
        }
    }

    // Implement toggleReveal() Function to toggle the blind box is revealed - week 9
    function toggleReveal() external {
        revealed = !revealed;
    }

    // Implement setBaseURI(newBaseURI) Function to set BaseURI - week 9
    function setBaseURI(string memory newBaseURI) external {
        baseURI = newBaseURI;
    }

    // Function to return the base URI
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    // Early mint function for people on the whitelist - week 9
    function earlyMint(bytes32[] calldata _merkleProof, uint256 _mintAmount) public payable {
        //Please make sure you check the following things:
        //Current state is available for Early Mint
        require(earlyMintActive, "not early mint state");
        //Check how many NFTs are available to be minted
        require(_nextTokenId.current() + _mintAmount <= maxSupply, "too late");
        //Check user is in the whitelist - use merkle tree to validate
        MerkleProof.verify(_merkleProof, merkleRoot, msg.sender);
        //Check user has sufficient funds
    }

    // Implement toggleEarlyMint() Function to toggle the early mint available or not - week 9
    function toggleEarlyMint() external {
        earlyMintActive = !earlyMintActive;
    }

    // Implement setMerkleRoot(merkleRoot) Function to set new merkle root - week 9

    // Let this contract can be upgradable, using openzepplin proxy library - week 10
    // Try to modify blind box images by using proxy
}
