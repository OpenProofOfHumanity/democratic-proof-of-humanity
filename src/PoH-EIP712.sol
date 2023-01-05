// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";

contract POH_EIP712 is EIP712 {
	constructor() EIP712("Proof of Humanity", "2") {}

	function DOMAIN_SEPARATOR() external view returns (bytes32) {
		return _domainSeparatorV4();
	}
}
