// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {HumanityStatus} from "../data-structures/HumanityStatus.sol";
import {IData} from "./IData.sol";

contract Data is IData {
	event HumanityStatusUpdated(uint256 humanId, HumanityStatus status);

	/*
		!* maybe not necessary -> view getter
		1. check if token exists
		2. check if there's a recovery request
		3. return token owner
	*/
	mapping(uint256 => HumanityStatus) private _status;

	function updateStatus(uint256 humanId, HumanityStatus newStatus) external {
		// pending: check msg.sender
		_status[humanId] = newStatus;
	}

	function statusOf(uint256 humanId) external view returns (HumanityStatus) {
		return _status[humanId];
	}
}
