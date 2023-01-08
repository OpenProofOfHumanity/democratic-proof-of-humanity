// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IRegistration} from "./IRegistration.sol";
import {ISBT} from "../sbt/ISBT.sol";
import {IStage} from "../IStage.sol";
import {IRegistrationVerification} from "./verification/IRegistrationVerification.sol";

import {Submission, Submissions, RequestStatus} from "../data-structures/Submissions.sol";

import {AlreadyHuman, AlreadySubmitted, IncompleteVouching, IncompleteFunding} from "../data-structures/Errors.sol";

contract Registration is IRegistration {
	using Submissions for Submission;

	event AddSubmission(uint256 humanId, address submitter, string evidence);
	event PendingVerification(uint256 humanId);

	Submission[] private _submissions;
	mapping(address => bool) _submitted;

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

	function addSubmission(string calldata evidence) external {
		_addSubmission(msg.sender, evidence);
	}

	function _addSubmission(address _submitter, string calldata _evidence) private {
		if (_sbt.balanceOf(_submitter) != 0) revert AlreadyHuman(_submitter);
		if (_submitted[_submitter]) revert AlreadySubmitted(_submitter);

		Submission storage _submission = _submissions.push();
		uint256 _humanId = _submissions.length - 1;

		_submission.initialAddress = _submitter;
		_submission.submissionTimestamp = block.timestamp;
		// _submission. pendingVerificationFrom -> default: 0
		_submission.evidence = _evidence;
		_submission.status = RequestStatus.VouchingAndFunding;

		_submitted[_submitter] = true;

		emit AddSubmission(_humanId, _submitter, _evidence);
	}

	function moveToVerification(uint256 requestId) external {
		if (!_vouching.complete(requestId)) revert IncompleteVouching(requestId);
		if (!_funding.complete(requestId)) revert IncompleteFunding(requestId);

		_submissions[requestId].updateStatus(RequestStatus.PendingVerification);
		_verification.startProcess(requestId);

		emit PendingVerification(requestId);
	}
}
