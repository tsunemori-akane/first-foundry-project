// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;
// source https://blog.wssh.trade/posts/foundry-contract-upgrade-part1/
// 逻辑与数据存储分离

contract ProxyStorage {
    address public otherContractAddress;

    function setOtherAddressStorage(address _otherContract) internal {
        otherContractAddress = _otherContract;
    }
}

contract DataLayout is ProxyStorage {
    uint256 public number;
}

contract NumberStorage is DataLayout {
    function setNumber(uint256 _uint) public {
        number = _uint;
    }

    function getNumber() public view returns (uint256) {
        return number;
    }
}

contract NumberStorageUp is DataLayout {
    function setNumber(uint256 _uint) public {
        number = _uint;
    }

    function getNumber() public view returns (uint256) {
        return number;
    }

    function addNumber() public {
        number += 1;
    }
}

contract ProxyEasy is ProxyStorage {
    constructor(address _otherContract) {
        setOtherAddress(_otherContract);
    }

    function setOtherAddress(address _otherContract) public {
        super.setOtherAddressStorage(_otherContract);
    }

    fallback() external {
        address _impl = otherContractAddress;

        assembly {
            let ptr := mload(0x40)
            calldatacopy(ptr, 0, calldatasize())
            let result := delegatecall(gas(), _impl, ptr, calldatasize(), 0, 0)
            let size := returndatasize()
            returndatacopy(ptr, 0, size)

            switch result
            case 0 { revert(ptr, size) }
            default { return(ptr, size) }
        }
    }
}
