// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FixedSupplyERC20 is ERC20, Ownable {
    uint256 private _totalSupply;
    mapping(address => uint256) _balances;

    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) Ownable(msg.sender) { }

    function mint(address to, uint256 value) external {
        _totalSupply += value;
        _balances[to] = _balances[to] += value;
    }

    function burn(uint256 value) internal virtual {
        uint256 remaining_balance = _balances[msg.sender];
        require(remaining_balance >= value, "burn amount exceeds balance");
        unchecked {
            _balances[msg.sender] = remaining_balance - value;
        }
        _totalSupply -= value;
    }
}
