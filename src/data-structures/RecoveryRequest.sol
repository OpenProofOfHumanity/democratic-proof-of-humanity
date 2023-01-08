// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {RequestStatus} from "./RequestStatus.sol";

struct RecoveryRequest {
	address from;
	address to;
	uint256 requestTimestamp;
	uint256 pendingFrom;
	string evidence;
	RequestStatus status;
}
