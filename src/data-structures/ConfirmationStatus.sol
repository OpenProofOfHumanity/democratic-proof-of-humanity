// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

enum ConfirmationStatus {
	None,
	Pending, // can be challenged
	Rejected, // rejected submission
	Verified // requested recovery. next status -> verified
}