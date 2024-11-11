// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { ERC20 } from "../../src/contracts/ERC20.sol";

contract FixedSupplyERC20 is ERC20 {
    uint8 private _totalSupply;
    uint8 private constant _decimals = 18;

    constructor() ERC20("fixed", "fs", _decimals) {
        _mint(msg.sender, 1000 * 10 ** _decimals);
    }
}
