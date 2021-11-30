pragma solidity ^0.5.0;

import "../lib/access/TicketBurnerRole.sol";

import "../interfaces/ITicketBurn.sol";
import "./common/TicketCommon.sol";

contract TicketBurn is ITicketBurn, TicketCommon {

    function _burn(address owner, uint256 tokenId) internal {
        require(ownerOf(tokenId) == owner, "Burn of token that is not own");

        _clearApproval(tokenId);

        _ownedTokensCount[owner].decrement();
        _tokenOwner[tokenId] = address(0);

        emit Transfer(owner, address(0), tokenId);
    }
}
