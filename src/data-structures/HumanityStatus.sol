// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

enum HumanityStatus {
	None,
	Submitted, // vouching and funding
	Verification, // can be challenged
	Denied, // rejected submission
	Verified, // approved submission
	RecoveryRequested // requested recovery. next status -> verified
}
