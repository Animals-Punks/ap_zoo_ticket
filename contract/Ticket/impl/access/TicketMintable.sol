pragma solidity ^0.5.0;

import "../../../shared/KIP17/impl/KIP13.sol";

import "../../lib/access/TicketMinterRole.sol";

import "../TicketMint.sol";

contract TicketMintable is TicketMinterRole, TicketMint, KIP13 {
    bytes4 private constant _INTERFACE_ID_TICKET_MINTABLE = 0xeab83e20;

    constructor() public {
        _registerInterface(_INTERFACE_ID_TICKET_MINTABLE);
    }

    function mint(address to, uint256 tokenId) public onlyMinter returns (bool) {
        _mint(to, tokenId);
        return true;
    }
}