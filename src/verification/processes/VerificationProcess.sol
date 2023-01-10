// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

// interfaces

import {IVerificationProcess} from "./IVerificationProcess.sol";
import {ISBT} from "../../sbt/ISBT.sol";
import {IVerificationPhase} from "../phases/IVerificationPhase.sol";
import {IConfirmation} from "../phases/confirmation/IConfirmation.sol";

// data structures
import {RequestStatus} from "../../data-structures/RequestStatus.sol";
import {RequestData} from "../../data-structures/RequestData.sol";
import {RequestType} from "../../data-structures/RequestType.sol";

// errors
import {IncompleteVouching, IncompleteFunding, IncompleteConfirmation, InvalidCurrentStatus, AnotherPendingRequest} from "../../data-structures/Errors.sol";

abstract contract VerificationProcess is IVerificationProcess {
	event NewRequest(uint256 requestId, address requester, string evidence);
	event StatusUpdate(uint256 requestId, RequestStatus newStatus);

	RequestType internal _requestType;

	RequestData[] internal _requests;
	mapping(address => bool) _pendingRequest;

	ISBT internal _sbt;

	IVerificationPhase private _vouching;
	IVerificationPhase private _funding;
	IConfirmation private _confirmation;

	modifier currentStatus(uint256 requestId, RequestStatus expectedStatus) {
		if (requestStatus(requestId) != expectedStatus)
			revert InvalidCurrentStatus(requestId, requestStatus(requestId), expectedStatus);
		_;
	}

	constructor(RequestType requestType, address sbt, address vouching, address funding, address confirmation) {
		_requestType = requestType;

		_sbt = ISBT(sbt);
		_vouching = IVerificationPhase(vouching);
		_funding = IVerificationPhase(funding);
		_confirmation = IConfirmation(confirmation);
	}

	function requestStatus(uint256 requestId) public view virtual returns (RequestStatus) {
		return _requests[requestId].status;
	}

	function _updateStatus(uint256 _requestId, RequestStatus _newStatus) private {
		_requests[_requestId].status = _newStatus;

		emit StatusUpdate(_requestId, _newStatus);
	}

	function addRequest(string calldata evidence) external {
		_beforeNewRequest(msg.sender);

		RequestData storage _request = _requests.push();
		uint256 _requestId = _requests.length - 1;

		_request.requester = msg.sender;
		_request.submissionTimestamp = block.timestamp;
		// _request. pendingConfirmationFrom -> default: 0
		_request.evidence = evidence;
		_request.status = RequestStatus.VouchingAndFunding;

		_pendingRequest[msg.sender] = true;

		emit NewRequest(_requestId, msg.sender, evidence);
	}

	function _beforeNewRequest(address _requester) internal virtual {
		if (_pendingRequest[_requester]) revert AnotherPendingRequest(_requester);
		// can be called in child contracts using super and adding other requirements
	}

	function moveToConfirmation(uint256 requestId) external currentStatus(requestId, RequestStatus.VouchingAndFunding) {
		if (!_vouching.complete(_requestType, requestId)) revert IncompleteVouching(requestId);
		if (!_funding.complete(_requestType, requestId)) revert IncompleteFunding(requestId);

		_updateStatus(requestId, RequestStatus.PendingConfirmation);

		_confirmation.startProcess(_requestType, requestId);
	}

	function processRequest(uint256 requestId) external currentStatus(requestId, RequestStatus.PendingConfirmation) {
		if (!_confirmation.complete(_requestType, requestId)) revert IncompleteConfirmation(requestId);

		_updateStatus(requestId, RequestStatus.Verified);

		_applyRequestEffects(requestId);
	}

	// override in child contracts depending on request type
	function _applyRequestEffects(uint256 _requestId) internal virtual;
}
