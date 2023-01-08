// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {RequestStatus} from "./RequestStatus.sol";

struct RegistrationRequest {
	address initialAddress;
	uint256 requestTimestamp;
	uint256 pendingVerificationFrom;
	string evidence;
	RequestStatus status;
}

library RegistrationRequests {
	function updateStatus(RegistrationRequest storage self, RequestStatus newStatus) internal {
		self.status = newStatus;
	}
}
