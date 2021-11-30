pragma solidity ^0.5.0;

import "../interfaces/ITicketMint.sol";
import "./common/TicketCommon.sol";

contract TicketMint is ITicketMint, TicketCommon {

    function _mint(address to, uint256 tokenId) internal {
        require(to != address(0), "Mint to the zero address");
        require(!_exists(tokenId), "Token already minted");

        _tokenOwner[tokenId] = to;
        _ownedTokensCount[to].increment();

        emit Transfer(address(0), to, tokenId);
    }
}