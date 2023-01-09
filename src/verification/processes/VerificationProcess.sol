// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IVerificationProcess} from "./IVerificationProcess.sol";
import {RequestStatus} from "../../data-structures/RequestStatus.sol";
import {RequestData} from "../../data-structures/RequestData.sol";
import {IVerificationPhase} from "../phases/IVerificationPhase.sol";
import {IConfirmation} from "../phases/confirmation/IConfirmation.sol";

// errors
import {AlreadySubmitted, IncompleteVouching, IncompleteFunding, IncompleteVerification, InvalidCurrentStatus} from "../data-structures/Errors.sol";

abstract contract VerificationProcess is IVerificationProcess {
	event NewRequest(uint256 requestId, uint256 requester, string evidence);
	event NewPhase(uint256 requestId, RequestStatus newStatus);

	RequestData[] private _requests;
	mapping(address => bool) _requested;

	// ISBT private _sbt;

	IVerificationPhase private _vouching;
	IVerificationPhase private _funding;
	IConfirmation private _confirmation;

	modifier currentStatus(uint256 requestId, RequestStatus expectedStatus) {
		if (requestStatus(requestId) != expectedStatus)
			revert InvalidCurrentStatus(requestId, requestStatus(requestId), expectedStatus);
		_;
	}

	constructor(address token, address vouching, address funding, address confirmation) {
		// _sbt = ISBT(token);
		_vouching = IVerificationPhase(vouching);
		_funding = IVerificationPhase(funding);
		_confirmation = IConfirmation(confirmation);
	}

	function requestStatus(uint256 requestId) public view virtual returns (RequestStatus) {
		return _requests[requestId].status;
	}
}
