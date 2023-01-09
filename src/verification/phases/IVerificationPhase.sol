// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {RequestType} from "../../data-structures/RequestType.sol";

interface IVerificationPhase {
	function complete(RequestType requestType, uint256 requestId) external returns (bool);
}
