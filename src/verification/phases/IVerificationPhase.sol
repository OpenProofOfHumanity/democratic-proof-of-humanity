// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IVerificationPhase {
	function complete(uint256 requestId) external returns (bool);
}
