// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { ERC20 } from "../../src/contracts/openzeppelin/ERC20.sol";

contract MockERC20 is ERC20 {
    uint8 private _decimals;

    constructor(string memory name_, string memory symbol_, uint8 decimals_) ERC20(name_, symbol_) {
        _decimals = decimals_;
    }

    function decimals() public view override returns (uint8) {
        return _decimals;
    }

    function mint(address recipient_, uint256 amount_) external {
        return _mint(recipient_, amount_);
    }
}
