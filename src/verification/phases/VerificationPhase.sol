// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IVerificationPhase} from "./IVerificationPhase.sol";

import {RequestType} from "../../data-structures/RequestType.sol";

import {InvalidSender} from "../../data-structures/Errors.sol";

abstract contract VerificationPhase is IVerificationPhase {
	mapping(RequestType => address) private _verificationContracts;

	modifier onlyVerificationContract(RequestType requestType) {
		if (msg.sender != _verificationContracts[requestType]) revert InvalidSender(msg.sender);
		_;
	}

	constructor() {}

	function setVerificationContracts(address[] memory addrs) external {
		// pending: onlyGovernor
		for (uint256 i = 0; i < addrs.length; i++) {
			address addr = addrs[i];
			if (addr != address(0)) _verificationContracts[RequestType(i)] = addr;
		}
	}
}
