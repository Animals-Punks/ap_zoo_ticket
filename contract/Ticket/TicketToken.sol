pragma solidity ^0.5.0;

import "./interfaces/ITicketToken.sol";
import "./impl/access/TicketBurnable.sol";
import "./impl/access/TicketMintable.sol";
import "./impl/TicketFull.sol";

contract TicketToken is ITicket, TicketFull, TicketBurnable, TicketMintable {
    using TokenCounters for TokenCounters.Counter;

    string TOKEN_NAME = "Animals Punks Ticket";
    string TOKEN_SYMBOL = "APT";
    uint256 MAX_TICKET_SUPPLY = 10000;
    string private _baseTokenURI;
    address public minterContract;
    uint256 public _max_ticket_supply;
    address public klubsContract;
    
    TokenCounters.Counter private _tokenIdTracker;

    constructor(string memory baseTokenURI) public TicketFull(TOKEN_NAME, TOKEN_SYMBOL) {
        _baseTokenURI = baseTokenURI;
        _max_ticket_supply = MAX_TICKET_SUPPLY;
    }

    function mintToken(address to) public onlyMinter {
        require(totalSupply() < _max_ticket_supply, "Mint end");
        uint256 currentTokenId =  _tokenIdTracker.current();
        _mint(to, currentTokenId);
        _tokenIdTracker.increment();
    }

    function mintWithMetadata(address to, string[] metadata) public onlyMinter {
        require(totalSupply() < _max_ticket_supply, "Mint end");
        uint256 currentTokenId =  _tokenIdTracker.current();
        _mint(to, currentTokenId);
        setTokenURI(currentTokenId, _baseTokenURI);
        setTokenProperty(currentTokenId, metadata);
        _tokenIdTracker.increment();
    }

    function approvalForAll(address _owner, address _operator) public view returns (bool) {
        // if Klubs KIP17 Proxy Address is detected, auto-return true
        if (_operator == klubsContract) {
            return true;
        }
        return isApprovedForAll(_owner, _operator);
        // return false;
    }

    function setKlubsContract(address _klubsContract) public {
        require(isMinter(msg.sender), "You are not minter");
		klubsContract = address(_klubsContract);
	}

    function safeTransferFrom(address from, address to, uint256 tokenId) public {
        require(_max_ticket_supply < tokenId, "Token id override");
        safeTransferFrom(from, to, tokenId);
    }
    
    function setMinterContract(address saleContract) public {
        require(isMinter(msg.sender), "You are not minter");
        minterContract = saleContract;
    }

    function setBaseURI(string memory baseURI) public {
        require(isMinter(msg.sender), "You are not minter");
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