pragma solidity ^0.5.0;

import "../shared/KIP17/KIP17Token.sol";
import "../shared/KIP17/lib/access/roles/MinterRole.sol";
import "../shared/KIP17/lib/TokenCounters.sol";

contract Ticket is KIP17Token {
    using TokenCounters for TokenCounters.Counter;

    string TOKEN_NAME = "Animals Punks Ticket";
    string TOKEN_SYMBOL = "APT";
    uint256 MAX_TICKET_SUPPLY = 10000;
    string private _baseTokenURI;
    address public minterContract;
    uint256 public _max_ticket_supply;
    
    TokenCounters.Counter private _tokenIdTracker;

    constructor(string memory baseTokenURI) public KIP17Token(TOKEN_NAME, TOKEN_SYMBOL) {
        _baseTokenURI = baseTokenURI;
        _max_ticket_supply = MAX_TICKET_SUPPLY;
    }

    function mintToken(address to) public {
        require(isMinter(msg.sender), "You are not minter");
        require(totalSupply() < _max_ticket_supply, "Mint end");
        _mint(to, _tokenIdTracker.current());
        _tokenIdTracker.increment();
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        require(_max_ticket_supply < tokenId, "Token id override");
        safeTransferFrom(from, to, tokenId);
    }
    
    function setMinterContract(address saleContract) public {
        minterContract = saleContract;
    }

    function setBaseURI(string memory baseURI) public {
        _baseTokenURI = baseURI;
    }

    function burn(address reqOwner, uint256 tokenId) public {
        require(isMinter(msg.sender), "You are not minter");
        address owner = getOwnerOf(tokenId);
        require(owner != reqOwner, "Owner un-match");
        _burn(owner, tokenId);
    }

    function getBaseURI() public view returns (string memory) {
        return _baseURI();
    }
    
    function getOwnerOf(uint256 tokenId) public view returns (address) {
        return _getOwnerOf(tokenId);
    }
    

    function _baseURI() internal view returns (string memory) {
        return _baseTokenURI;
    }
    
    function _getOwnerOf(uint256 tokenId) internal view returns (address) {
        address owner = ownerOf(tokenId);
        return owner;
    }
}