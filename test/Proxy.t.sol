// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;
// forge test --match-path test/Proxy.t.sol

import { Test } from "forge-std/src/Test.sol";
import "./mocks/Proxy.sol";

contract ContractTest is Test {
    NumberStorage private numberStorage;
    NumberStorageUp private numberStorageUp;
    ProxyEasy private proxy;

    function setUp() public {
        numberStorage = new NumberStorage();
        numberStorageUp = new NumberStorageUp();
        address numberAddress = address(numberStorage);
        proxy = new ProxyEasy(numberAddress);
    }

    function testGetNumber() public {
        (bool ok,) = address(proxy).call(abi.encodeWithSignature("setNumber(uint256)", 100));
        if (!ok) {
            revert("DelegateCall Error");
        }

        (bool success, bytes memory data) = address(proxy).call(abi.encodeWithSignature("getNumber()"));

        if (!success) {
            revert("DelegateCall Error");
        }
        uint256 returnNumber = abi.decode(data, (uint256));
        assertEq(returnNumber, 100);
    }

    function testNumberUpgrade() public {
        (bool ok,) = address(proxy).call(abi.encodeWithSignature("setNumber(uint256)", 100));
        if (!ok) {
            revert("DelegateCall Error");
        }

        proxy.setOtherAddress(address(numberStorageUp));

        (bool addSuccess,) = address(proxy).call(abi.encodeWithSignature("addNumber()"));

        if (!addSuccess) {
            revert("Add Fail");
        }

        (bool success, bytes memory data) = address(proxy).call(abi.encodeWithSignature("getNumber()"));

        if (!success) {
            revert("DelegateCall Error");
        }
        uint256 returnNumber = abi.decode(data, (uint256));
        assertEq(returnNumber, 101);
    }
}
