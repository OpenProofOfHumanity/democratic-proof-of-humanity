// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IRegistration} from "./IRegistration.sol";
import {ISBT} from "../sbt/ISBT.sol";
import {Submission, RequestStatus} from "../data-structures/Submission.sol";

contract Registration is IRegistration {
	Submission[] private _submissions;

	ISBT private _sbt;

	constructor(address token) {
		_sbt = ISBT(token);
	}

	function addSubmission(string calldata evidence) external {
		_addSubmission(msg.sender, evidence);
	}

	function _addSubmission(address initialAddress, string calldata evidence) private {
		if (_sbt.balanceOf(initialAddress) != 0) revert();
	}
}
