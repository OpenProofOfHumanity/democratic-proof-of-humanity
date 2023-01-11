// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IRegistration} from "./IRegistration.sol";
import {VerificationProcess} from "../VerificationProcess.sol";

import {RequestType} from "../../../data-structures/RequestType.sol";

abstract contract Registration is IRegistration, VerificationProcess {
	constructor(
		address sbt,
		address vouching,
		address funding,
		address confirmation
	) VerificationProcess(RequestType.Registration, sbt, vouching, funding, confirmation) {}

	function _beforeNewRequest(address _requester) internal override {
		super._beforeNewRequest(_requester);
		// pending: already human
	}

	function _applyRequestEffects(uint256 _requestId) internal override {
		_sbt.mint(_requestId, _requests[_requestId].requester);
	}
}
