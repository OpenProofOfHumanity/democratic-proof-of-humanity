// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

enum HumanityStatus {
	None,
	Verified, // approved submission
	RecoveryRequested // requested recovery. next status -> verified
}
