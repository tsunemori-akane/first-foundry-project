// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import "../src/contracts/ERC20.sol";
import { MockERC20 } from "./mocks/MockERC20.sol";
import { Test } from "forge-std/src/Test.sol";

contract ERC20Test is Test {
    MockERC20 internal _token;

    function setup() public virtual {
        _token = new MockERC20(unicode"Анна", unicode"кот", 18);
    }

    function test_metadata(string memory name_, string memory symbol_, uint8 decimals_) public {
        MockERC20 mockToken = new MockERC20(name_, symbol_, decimals_);
        assertEq(mockToken.name(), name_);
    }

    function test_mint(address account_, uint256 amount_) public {
        _token.mint(account_, amount_);
        assertEq(_token.totalSupply(), amount_);
    }
}
