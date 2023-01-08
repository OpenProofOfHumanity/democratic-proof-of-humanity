// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IStage {
	function complete(uint256) external returns (bool);
}
