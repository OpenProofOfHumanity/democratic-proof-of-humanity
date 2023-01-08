// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IRegistrationFunding {
	function amountNeeded() external view returns (uint256);

	function alreadyFunded(uint256 requestId) external view returns (uint256);

	function leftToBeFunded(uint256 requestId) external view returns (uint256);

	function fundingComplete(uint256 requestId) external view returns (bool);

	function fund(uint256 requestId) external;
}
