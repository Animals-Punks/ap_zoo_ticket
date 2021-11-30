pragma solidity ^0.5.0;

contract ITicket  {
    function mintToken(address to) public;
    function safeTrnsferFrom(address from, address to, uint256 tokenId) public;
    function setMinterContract(address saleContract) public;
    function setBaseURI(string memory baseURI) public;
    function getBaseURI() public view returns (string memory);
    function getOwnerOf(uint256 tokneId) public view returns (address);
}