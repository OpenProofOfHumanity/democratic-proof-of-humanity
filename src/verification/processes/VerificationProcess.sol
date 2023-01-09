// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IVerificationProcess} from "./IVerificationProcess.sol";
import {RequestStatus} from "../../data-structures/RequestStatus.sol";
import {RequestData} from "../../data-structures/RequestData.sol";
import {IVerificationPhase} from "../phases/IVerificationPhase.sol";
import {IConfirmation} from "../phases/confirmation/IConfirmation.sol";

// errors
import {AlreadySubmitted, IncompleteVouching, IncompleteFunding, IncompleteConfirmation, InvalidCurrentStatus, AnotherPendingRequest} from "../../data-structures/Errors.sol";

abstract contract VerificationProcess is IVerificationProcess {
	event NewRequest(uint256 requestId, address requester, string evidence);
	event NewPhase(uint256 requestId, RequestStatus newStatus);

	RequestData[] private _requests;
	mapping(address => bool) _pendingRequest;

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

	function requestStatus(uint256 requestId) public view virtual returns (RequestStatus) {
		return _requests[requestId].status;
	}

	function _updateStatus(uint256 _requestId, RequestStatus _newStatus) private {
		_requests[_requestId].status = _newStatus;
	}
}
