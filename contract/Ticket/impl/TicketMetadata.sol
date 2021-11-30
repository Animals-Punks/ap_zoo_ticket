pragma solidity ^0.5.0;

import "../../shared/KIP17/impl/KIP13.sol";

import "./common/TicketCommon.sol";

contract TicketMetadata is KIP13, TicketCommon {
    string private _name;
    string private _symbol;

    mapping(uint256 => string) private _tokenURIs;
    mapping(uint256 => mapping (string => string)) private _ticketProperty;
    
    bytes4 private constant _INTERFACE_ID_KIP17_METADATA = 0x5b5e139f;

    constructor(string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;

        _registerInterface(_INTERFACE_ID_KIP17_METADATA);
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function property(uint256 tokenId) external view returns (string[]) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return _ticketProperty[tokneId];
    }

    function tokenURI(uint256 tokenId) internal view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return _tokenURIs[tokenId];
    }

    function setTokenURI(uint256 tokenId, string memory tokenURI) external onlyMinter {
        _setTokenURI(tokenId, tokenURI);
    }

    function setTokenProperty(uint256 tokenId, string[] property) external onlyMinter {
        _setTokenProperty(tokenId, property);
    }

    function _setTokenURI(uint256 tokneId, string memory tokenURI) internal {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        _tokenURIs[tokenId] = uri;
    }

    function _setTokenProperty(uint256 tokenId, string[] property) internal {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        _ticketProperty[tokenId] = property;
    }

    function _burn(address owner, uint256 tokenId) internal {
        super._burn(owner, tokenId);

        require(bytes(_tokenURIs[tokenId]).length > 0, "Set token uri first");
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}