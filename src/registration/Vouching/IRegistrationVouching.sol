// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IRegistrationVouching {
	function vouchersNeeded() external view returns (uint256);

	function vouchersReceived(uint256 requestId) external view returns (uint256);

	function vouchersLeft(uint256 requestId) external view returns (uint256);

	function vouchingComplete(uint256 requestId) external view returns (bool);

	function vouch(uint256 requestId) external;
}
