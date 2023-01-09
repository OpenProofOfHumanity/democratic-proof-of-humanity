// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IVerificationPhase} from "../IVerificationPhase.sol";
import {RequestType} from "../../../data-structures/RequestType.sol";

interface IConfirmation is IVerificationPhase {
	function startProcess(RequestType requestType, uint256 requestId) external;
}
