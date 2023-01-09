// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IVerificationProcess} from "./IVerificationProcess.sol";
import {RequestStatus} from "../../data-structures/RequestStatus.sol";
import {RequestData} from "../../data-structures/RequestData.sol";

abstract contract VerificationProcess is IVerificationProcess {
	event NewRequest(uint256 requestId, uint256 requester, string evidence);

	event NewPhase(uint256 requestId, RequestStatus newStatus);

	function necessaryVouches() external view virtual returns (uint256 amount);

	function necessaryFunding() external view virtual returns (address token, uint256 amount);

	function requestStatus(uint256 requestId) external view virtual returns (RequestStatus);
}
