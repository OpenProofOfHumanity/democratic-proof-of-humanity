// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IConfirmation} from "./IConfirmation.sol";
import {VerificationPhase} from "../VerificationPhase.sol";

abstract contract Confirmation is IConfirmation, VerificationPhase {}
