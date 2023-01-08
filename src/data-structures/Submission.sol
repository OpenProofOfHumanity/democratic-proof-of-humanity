// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {RequestStatus} from "./RequestStatus.sol";

struct Submission {
	address initialAddress;
	uint256 submissionTimestamp;
	uint256 pendingVerificationFrom;
	string evidence;
	RequestStatus status;
}
