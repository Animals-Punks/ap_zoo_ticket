pragma solidity ^0.5.0;

import "../../../shared/KIP17/impl/KIP13.sol";

import "../common/TicketCommon.sol";
import "../TicketBurn.sol";
import "../../lib/access/TicketBurnerRole.sol";

contract TicketBurnable is KIP13, TicketBurn {
    bytes4 private constant _INTERFACE_ID_KIP17_BURNABLE = 0x42966c68;

    constructor () public {
        _registerInterface(_INTERFACE_ID_KIP17_BURNABLE);
    }

    function burn(uint256 tokenId) public onlyBurner returns (bool) {
        require(_isApprovedOrOwner(msg.sender, tokenId), "KIP17Burnable: caller is not owner nor approved");
        _burn(tokenId);
    }
}