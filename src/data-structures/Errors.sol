// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

error NotHumanID(uint256 humanId);
error NotHumanAddress(address human);

error AlreadyHuman(address human);
error AlreadySubmitted(address submitter);

error UnauthorizedTransfer();

error IncompleteVouching(uint256 requestId);
error IncompleteFunding(uint256 requestId);
