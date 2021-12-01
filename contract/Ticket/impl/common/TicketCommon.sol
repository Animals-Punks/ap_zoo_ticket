pragma solidity ^0.5.0;

import "../../lib/utils/Address.sol";
import "../../lib/utils/Counters.sol";
import "../../lib/utils/SafeMath.sol";
import "../../interfaces/common/ITicketCommon.sol";

contract TicketCommon is ITicketCommon {
    using SafeMath for uint256;
    using Address for address;
    using Counters for Counters.Counter;

    mapping (uint256 => address) private _tokenOwner;
    mapping (address => Counters.Counter) private _ownedTokensCount;
    mapping (uint256 => address) private _tokenApprovals;
    mapping (address => mapping (address => bool)) private _operatorApprovals;

    function balanceOf(address owner) public view returns (uint256) {
        require(owner != address(0), "KIP17: balance query for the zero address");

        return _ownedTokensCount[owner].current();
    }

    function ownerOf(uint256 tokenId) public view returns (address) {
        address owner = _tokenOwner[tokenId];
        require(owner != address(0), "KIP17: owner query for nonexistent token");

        return owner;
    }

    function approve(address to, uint256 tokenId) public {
        address owner = ownerOf(tokenId);
        require(to != owner, "KIP17: approval to current owner");

        require(msg.sender == owner || isApprovedForAll(owner, msg.sender),
            "KIP17: approve caller is not owner nor approved for all"
        );

        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

    function getApproved(uint256 tokenId) public view returns (address) {
        require(_exists(tokenId), "KIP17: approved query for nonexistent token");

        return _tokenApprovals[tokenId];
    }

    function setApprovalForAll(address to, bool approved) public {
        require(to != msg.sender, "KIP17: approve to caller");

        _operatorApprovals[msg.sender][to] = approved;
        emit ApprovalForAll(msg.sender, to, approved);
    }

    function isApprovedForAll(address owner, address operator) public view returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    function _exists(uint256 tokenId) internal view returns (bool) {
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }

    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "Operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }

    function _clearApproval(uint256 tokenId) public {
        if (_tokenApprovals[tokenId] != address(0)) {
            _tokenApprovals[tokenId] = address(0);
        }
    }
}