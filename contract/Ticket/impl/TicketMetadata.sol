pragma solidity ^0.5.0;

import "./common/TicketCommon.sol";

contract TicketMetadata is TicketCommon {
    string private _name;
    string private _symbol;

    mapping(uint256 => string) private _tokenURIs;
    mapping(uint256 => string) private _property;

    constructor(string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function property(uint256 tokenId) external view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return _property[tokenId];
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return _tokenURIs[tokenId];
    }

    function setTokenURI(uint256 tokenId, string memory tokenUri) public {
        require(_exists(tokenId), "URI query for nonexistent token");
        _tokenURIs[tokenId] = tokenUri;
    }

    function setTokenProperty(uint256 tokenId, string memory properties) public {
        _setTokenProperty(tokenId, properties);
    }

    function _setTokenProperty(uint256 tokenId, string memory properties) internal {
        require(_exists(tokenId), "URI query for nonexistent token");
        _property[tokenId] = properties;
    }
}