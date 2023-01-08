// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {HumanityStatus} from "../data-structures/HumanityStatus.sol";
import {IData} from "./IData.sol";

contract Data is IData {
	mapping(uint256 => HumanityStatus) private _status;

	function statusOf(uint256 humanId) external view returns (HumanityStatus) {
		return _status[humanId];
	}
}
