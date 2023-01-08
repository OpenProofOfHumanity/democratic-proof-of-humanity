// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

enum RequestStatus {
	None,
	VouchingAndFunding, // vouching and funding
	PendingVerification, // can be challenged
	Denied, // rejected submission
	Verified
}
