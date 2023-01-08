// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IRegistration} from "./IRegistration.sol";
import {ISBT} from "../sbt/ISBT.sol";
import {IStage} from "../IStage.sol";

import {Submission, RequestStatus} from "../data-structures/Submission.sol";

import {AlreadyHuman, AlreadySubmitted} from "../data-structures/Errors.sol";

contract Registration is IRegistration {
	event AddSubmission(uint256 humanId, address submitter, string evidence);

	Submission[] private _submissions;
	mapping(address => bool) _submitted;

	ISBT private _sbt;

	IStage private _vouching;
	IStage private _funding;

	constructor(address token, address vouching, address funding) {
		_sbt = ISBT(token);
		_vouching = IStage(vouching);
		_funding = IStage(funding);
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
}
