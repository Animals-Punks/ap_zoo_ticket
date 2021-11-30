pragma solidity ^0.5.0;

import "./TicketMetadata.sol";
import "./TicketEnumerable.sol";
import "./TicketBurn.sol";
import "./TicketMint.sol";

contract TicketFull is TicketEnumerable, TicketMetadata, TicketBurn, TicketMint {
    constructor(string memory name, string memory symbol) public TicketMetadata(name, symbol) {}
}