// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {RequestStatus} from "./RequestStatus.sol";

// general

// humanity

error NotHumanID(uint256 humanId);
error NotHumanAddress(address human);

// transferability

error UnauthorizedTransfer();

// phases completion

error IncompleteVouching(uint256 requestId);
error IncompleteFunding(uint256 requestId);
error IncompleteConfirmation(uint256 requestId);

// process checks

error AlreadyHuman(address human);
error AnotherPendingRequest(address requester);
error InvalidCurrentStatus(uint256 requestId, RequestStatus current, RequestStatus expected);
