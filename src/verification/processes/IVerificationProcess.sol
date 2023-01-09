// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {RequestStatus} from "../../data-structures/RequestStatus.sol";

interface IVerificationProcess {
	function necessaryVouches() external view returns (uint256 amount);

	function necessaryFunding() external view returns (address token, uint256 amount);

	function requestStatus(uint256 requestId) external view returns (RequestStatus);
}
