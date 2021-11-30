pragma solidity ^0.5.0;

contract ITicketCommon {
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) public view returns (uint256);
    function ownerOf(uint256 tokenId) public view returns (address);
    function approve(address to, uint256 tokenId) public;
    function getApproved(uint256 tokenId) public view returns (address);
    function setApprovalForAll(address to, bool approved) public;
    function isApprovedForAll(address owner, address operator) public view returns (bool)
}