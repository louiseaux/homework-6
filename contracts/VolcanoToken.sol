//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

// import ERC721 and Ownable contracts from OpenZeppelin library
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoToken is ERC721("VolcanoToken", "VOL"), Ownable {

    uint256 tokenId;

    mapping(address => Token[]) public tokenData;

    struct Token {
        uint256 timestamp;
        uint256 tokenId;
        string tokenURI;
    }

    constructor() {}

    function mint(address _user, uint256 _tokenId) public onlyOwner {
        _safeMint(_user, _tokenId);
        
        Token memory newTokenData = Token(block.timestamp, _tokenId, "Hello, World!");
        tokenData[_user].push(newTokenData);

        tokenId++;
    }

    function burn(uint256 _tokenId) public onlyOwner {
        _burn(_tokenId);
    }
}
