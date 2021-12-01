pragma solidity ^0.5.0;

import "./interfaces/ITicketToken.sol";
import "./impl/TicketMetadata.sol";
import "./impl/TicketMint.sol";

contract TicketToken is ITicketToken, TicketMetadata, TicketMint {
    using TokenCounters for TokenCounters.Counter;
    using Strings for string;

    string TOKEN_NAME = "Animals Punks Tickets";
    string TOKEN_SYMBOL = "APT";
    uint256 MAX_TICKET_SUPPLY = 10000;
    string public _baseTokenURI;
    address private minterContract;
    uint256 private _max_ticket_supply;
    address public klubsContract;
    
    TokenCounters.Counter private _tokenIdTracker;

    constructor(string memory baseTokenURI) public TicketMetadata(TOKEN_NAME, TOKEN_SYMBOL) {
        _baseTokenURI = baseTokenURI;
        _max_ticket_supply = MAX_TICKET_SUPPLY;
    }

    function mintWithTokenId(address to) public onlyMinter {
        require(totalSupply() < _max_ticket_supply, "Mint end");
        uint256 currentTokenId =  _tokenIdTracker.current();
        _mint(to, currentTokenId);
        _tokenIdTracker.increment();
    }

    function mintWithMetadata(address to, string memory metadata) public onlyMinter {
        require(totalSupply() < _max_ticket_supply, "Mint end");
        uint256 currentTokenId =  _tokenIdTracker.current();
        _mint(to, currentTokenId);
        string memory strTokenId = uint2str(currentTokenId);
        string memory tokenURI = _baseTokenURI.concat(strTokenId);
        setTokenURI(currentTokenId, tokenURI);
        setTokenProperty(currentTokenId, metadata);
        _tokenIdTracker.increment();
    }

    function approvalForAll(address _owner, address _operator) public view returns (bool) {
        // if Klubs KIP17 Proxy Address is detected, auto-return true
        if (_operator == klubsContract) {
            return true;
        }
        return isApprovedForAll(_owner, _operator);
    }

    function setKlubsContract(address _klubsContract) public onlyMinter {
		klubsContract = address(_klubsContract);
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
        require(owner == reqOwner, "Owner un-match");
        _burn(owner, tokenId);
        _tokenIdTracker.decrement();
    }
    
    function uint2str(uint _i) internal pure returns (string memory) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len - 1;
        while (_i != 0) {
            bstr[k--] = byte(uint8(48 + _i % 10));
            _i /= 10;
        }
        return string(bstr);
    }
}