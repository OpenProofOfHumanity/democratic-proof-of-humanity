// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IVerificationProcess} from "./IVerificationProcess.sol";
import {RequestStatus} from "../../data-structures/RequestStatus.sol";
import {RequestData} from "../../data-structures/RequestData.sol";
import {IVerificationPhase} from "../phases/IVerificationPhase.sol";
import {IConfirmation} from "../phases/confirmation/IConfirmation.sol";

abstract contract VerificationProcess is IVerificationProcess {
	event NewRequest(uint256 requestId, uint256 requester, string evidence);
	event NewPhase(uint256 requestId, RequestStatus newStatus);

	RequestData[] private _requests;
	mapping(address => bool) _requested;

	// ISBT private _sbt;

	IVerificationPhase private _vouching;
	IVerificationPhase private _funding;
	IConfirmation private _confirmation;

	constructor(address token, address vouching, address funding, address confirmation) {
		// _sbt = ISBT(token);
		_vouching = IVerificationPhase(vouching);
		_funding = IVerificationPhase(funding);
		_confirmation = IConfirmation(confirmation);
	}

	function necessaryVouches() external view virtual returns (uint256 amount);

	function necessaryFunding() external view virtual returns (address token, uint256 amount);

	function requestStatus(uint256 requestId) external view virtual returns (RequestStatus);
}
