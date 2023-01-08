// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {HumanityStatus} from "../data-structures/HumanityStatus.sol";

interface IData {
	function statusOf(uint256 humanId) external view returns (HumanityStatus);
}
