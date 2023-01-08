// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IStage} from "../../IStage.sol";

interface IRegistrationVouching is IStage {
	function vouchersNeeded() external view returns (uint256);

	function vouchersReceived(uint256 requestId) external view returns (uint256);

	function vouchersLeft(uint256 requestId) external view returns (uint256);

	function vouch(uint256 requestId) external;
}
