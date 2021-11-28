pragma solidity ^0.5.0;

library Context {
    function _msgSender() internal view returns (address) {
        return msg.sender;
    }
}