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

        // _registerInterface(_INTERFACE_ID_KIP17_METADATA);
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function property(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return _property[tokenId];
    }

    function tokenURI(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return _tokenURIs[tokenId];
    }
    
    function imageUrl(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "KIP17Metadata: URI query for nonexistent token");
        return _imageUrls[tokenId];
    }

    function setTokenURI(uint256 tokenId, string memory tokenUri) internal {
        require(_exists(tokenId), "URI query for nonexistent token");
        _tokenURIs[tokenId] = tokenUri;
    }

    function setTokenProperty(uint256 tokenId, string memory properties) internal {
        _setTokenProperty(tokenId, properties);
    }
    
    function setTokenImageUrl(uint256 tokenId, string memory reqImageUrl) internal {
        _setTokenImageUrl(tokenId, reqImageUrl);
    }

    // function _setTokenURI(uint256 tokenId, string memory tokenURI) internal {
    //     require(_exists(tokenId), "URI query for nonexistent token");
    //     _tokenURIs[tokenId] = tokenURI;
    // }

    function _setTokenProperty(uint256 tokenId, string memory properties) private {
        require(_exists(tokenId), "URI query for nonexistent token");
        _property[tokenId] = properties;
    }
    
    function _setTokenImageUrl(uint256 tokenId, string memory reqImageUrl) private {
        require(_exists(tokenId), "URI query for nonexistent token");
        _imageUrls[tokenId] = reqImageUrl;
    }

    // function _burn(address owner, uint256 tokenId) internal {
    //     // super._burn(owner, tokenId);

    //     require(bytes(_tokenURIs[tokenId]).length > 0, "Set token uri first");
    //     if (bytes(_tokenURIs[tokenId]).length != 0) {
    //         delete _tokenURIs[tokenId];
    //     }
    // }
}