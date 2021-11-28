pragma solidity ^0.5.0;

import "../shared/KIP17/impl/KIP17Full.sol";
import "../shared/KIP17/lib/Context.sol";
import "../shared/KIP17/lib/Counters.sol";

contract Ticket is KIP17Full {
    using Counters for Counters.Counter;

    string TOKEN_NAME = "Animals Punks Zoo Ticket";
    string TOKEN_SYMBOL = "APZT";
    uint256 MAX_TICKET_SUPPLY = 10000;
    string private _baseTokenURI;
    address public minterContract;
    uint256 public _max_ticket_supply;

    Counters.Counter private _tokenIdTracker;

    modifier onlyMinter() {
        address msgSender = msg.sender;
        require(msgSender == minterContract);
        _;
    }

    constructor(string memory baseTokenURI) public KIP17Full(TOKEN_NAME, TOKEN_SYMBOL) {
        _baseTokenURI = baseTokenURI;
        _max_ticket_supply = MAX_TICKET_SUPPLY;
    }

    function mint(address to) external onlyMinter {
        require(totalSupply() < _max_ticket_supply, "Mint end");
        _mint(to, _tokenIdTracker.current());
        _tokenIdTracker.increment();
    }

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        require(_max_ticket_supply < tokenId, "Token id override");
        safeTransferFrom(from, to, tokenId);
    }
    
    function setMinterContract(address saleContract) public onlyMinter {
        minterContract = saleContract;
    }

    function setBaseURI(string memory baseURI) public onlyMinter {
        _baseTokenURI = baseURI;
    }

    function burn(address reqOwner, uint256 tokenId) public onlyMinter {
        address owner = ownerOf(tokenId);
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