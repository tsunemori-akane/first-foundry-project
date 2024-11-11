// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { ERC20 } from "../../src/contracts/ERC20.sol";

contract MockERC20 is ERC20 {
    constructor(string memory name_, string memory symbol_, uint8 decimals_) ERC20(name_, symbol_, decimals_) { }

    function mint(address recipient_, uint256 amount_) external {
        return _mint(recipient_, amount_);
    }

    function burn(address owner_, uint256 amount_) external {
        _burn(owner_, amount_);
    }
}
