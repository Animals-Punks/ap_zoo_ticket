pragma solidity ^0.5.0;

import "./KIP17.sol";

import "../lib/access/roles/MinterRole.sol";

/**
 * @title KIP17Mintable
 * @dev KIP17 minting logic.
 */
contract KIP17Mintable is KIP17, MinterRole {
    bytes4 private constant _INTERFACE_ID_KIP17_MINTABLE = 0xeab83e20;
    
    constructor () public {
        // register the supported interface to conform to KIP17Mintable via KIP13
        _registerInterface(_INTERFACE_ID_KIP17_MINTABLE);
    }

    /**
     * @dev Function to mint tokens.
     * @param to The address that will receive the minted tokens.
     * @param tokenId The token id to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(address to, uint256 tokenId) public onlyMinter returns (bool) {
        _mint(to, tokenId);
        return true;
    }
}