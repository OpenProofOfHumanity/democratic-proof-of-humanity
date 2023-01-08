// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IRegistration} from "./IRegistration.sol";
import {ISBT} from "../sbt/ISBT.sol";
import {IStage} from "../IStage.sol";
import {IRegistrationVerification} from "./verification/IRegistrationVerification.sol";

import {RegistrationRequest, RegistrationRequests, RequestStatus} from "../data-structures/RegistrationRequest.sol";

import {AlreadyHuman, AlreadySubmitted, IncompleteVouching, IncompleteFunding} from "../data-structures/Errors.sol";

contract Registration is IRegistration {
	using RegistrationRequests for RegistrationRequest;

	event RegistrationRequested(uint256 humanId, address submitter, string evidence);
	event PendingVerification(uint256 humanId);

	RegistrationRequest[] private _requests;
	mapping(address => bool) _requested;

	ISBT private _sbt;

	IStage private _vouching;
	IStage private _funding;
	IRegistrationVerification private _verification;

	constructor(address token, address vouching, address funding, address verification) {
		_sbt = ISBT(token);
		_vouching = IStage(vouching);
		_funding = IStage(funding);
		_verification = IRegistrationVerification(verification);
	}

	function requestRegistration(string calldata evidence) external {
		_requestRegistration(msg.sender, evidence);
	}

	function _requestRegistration(address _requester, string calldata _evidence) private {
		if (_sbt.balanceOf(_requester) != 0) revert AlreadyHuman(_requester);
		if (_requested[_requester]) revert AlreadySubmitted(_requester);

		RegistrationRequest storage _request = _requests.push();
		uint256 _humanId = _requests.length - 1;

		_request.initialAddress = _requester;
		_request.requestTimestamp = block.timestamp;
		// _request. pendingVerificationFrom -> default: 0
		_request.evidence = _evidence;
		_request.status = RequestStatus.VouchingAndFunding;

		_requested[_requester] = true;

		emit RegistrationRequested(_humanId, _requester, _evidence);
	}

	function moveToVerification(uint256 requestId) external {
		if (!_vouching.complete(requestId)) revert IncompleteVouching(requestId);
		if (!_funding.complete(requestId)) revert IncompleteFunding(requestId);

		_requests[requestId].updateStatus(RequestStatus.PendingVerification);
		_verification.startProcess(requestId);

		emit PendingVerification(requestId);
	}
}
