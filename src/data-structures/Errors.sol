// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {RequestStatus} from "./RequestStatus.sol";

error NotHumanID(uint256 humanId);
error NotHumanAddress(address human);

error AlreadyHuman(address human);
error AlreadySubmitted(address submitter);

error UnauthorizedTransfer();

error IncompleteVouching(uint256 requestId);
error IncompleteFunding(uint256 requestId);
error IncompleteConfirmation(uint256 requestId);

error InvalidCurrentStatus(uint256 requestId, RequestStatus current, RequestStatus expected);
