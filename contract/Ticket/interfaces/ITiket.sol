pragma solidity ^0.5.0;

contract ITicket  {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
	event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
	event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function mintToken(address to) public;
    function safeTrnsferFrom(address from, address to, uint256 tokenId) public;
    function setMinterContract(address saleContract) public;
    function setBaseURI(string memory baseURI) public;
    function getBaseURI() public view returns (string memory);
    function getOwnerOf(uint256 tokneId) public view returns (address);
}