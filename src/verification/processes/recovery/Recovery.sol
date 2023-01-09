// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IRecovery} from "./IRecovery.sol";
import {VerificationProcess} from "../VerificationProcess.sol";

contract Recovery is IRecovery, VerificationProcess {}