pragma solidity ^0.5.0;

import "../utils/Roles.sol";

contract TicketBurnerRole {
    using Roles for Roles.Role;

    event BurnerAdded(address indexed account);
    event BurnerRemoved(address indexed account);

    Roles.Role private _minters;

    modifier onlyBurner() {
        require(isBurner(msg.sender),  "Caller does not have minter role");
        _;
    }

    constructor() internal {
        _addBurner(msg.sender);
    }

    function isBurner(address account) public view returns (bool) {
        return _minters.has(account);
    }

    function addBurner(address account) public onlyBurner {
        _addBurner(account);
    }

    function removeBurner(address account) public {
        _removeBurner(account);
    }

    function _addBurner(address account) internal {
        _minters.add(account);
        emit BurnerAdded(account);
    }

    function _removeBurner(address account) internal {
        _minters.remove(account);
        emit BurnerRemoved(account);
    }
}