// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {RequestStatus} from "./RequestStatus.sol";

struct RequestData {
	address requester;
	uint256 submissionTimestamp;
	uint256 pendingConfirmationFrom;
	string evidence;
	RequestStatus status;
}
