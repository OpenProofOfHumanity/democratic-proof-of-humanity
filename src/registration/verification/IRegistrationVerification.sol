// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IStage} from "../../IStage.sol";

interface IRegistrationVerification is IStage {
	function startProcess(uint256 requestId) external;
}
