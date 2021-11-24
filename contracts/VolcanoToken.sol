//SPDX-License-Identifier: Unlicense

pragma solidity ^0.8.0;

// import ERC721 and Ownable contracts from OpenZeppelin library
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoToken is ERC721("VolcanoToken", "VOL"), Ownable {

    uint256 public tokenId;

    struct TokenData {
        uint256 timestamp;
        uint256 tokenId;
        string tokenURI;
    }

    mapping(address => TokenData[]) public tokenData;
    event newToken(uint256);

    constructor() {}

    function mint(address _user) public onlyOwner {
        _safeMint(_user, tokenId);
        
        TokenData memory newTokenData = TokenData(block.timestamp, tokenId, "Hello, World!");
        tokenData[_user].push(newTokenData);

        tokenId++;
        emit newToken(tokenId);
    }

    function burn(uint256 _tokenId) public {
        require(msg.sender == ownerOf(_tokenId), "Caller is not owner");
        removeTokenData(msg.sender, _tokenId);
        _burn(_tokenId);
    }

    function removeTokenData(address _user, uint256 _tokenId) internal {
        for (uint i=0; i < tokenData[_user].length; i++) {
            if (tokenData[_user][i].tokenId == _tokenId) {
                delete tokenData[_user][i];
            }
        }
    }

    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");
        return tokenData[ownerOf(_tokenId)][_tokenId].tokenURI;
    } 
}
