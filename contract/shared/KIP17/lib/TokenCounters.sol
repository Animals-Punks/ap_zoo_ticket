pragma solidity ^0.5.0;

import "./SafeMath.sol";

library TokenCounters {
    using SafeMath for uint256;

    struct Counter {
        uint256 _value;
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        counter._value += 1;
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: devrement overflow");
        counter._value = counter._value.sub(1);
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}