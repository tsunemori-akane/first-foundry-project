// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FixedSupplyERC20 is ERC20 {
    constructor(string memory name_, string memory symbol_, uint8 amountToMint_) ERC20(name_, symbol_) {
        _mint(msg.sender, amountToMint_);
    }
}
