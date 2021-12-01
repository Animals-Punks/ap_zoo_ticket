pragma solidity ^0.5.0;

import "./TicketMetadata.sol";
import "./TicketEnumerable.sol";
import "./TicketMint.sol";

contract TicketFull is TicketEnumerable, TicketMetadata, TicketMint {
    constructor(string memory name, string memory symbol) public TicketMetadata(name, symbol) {}
}