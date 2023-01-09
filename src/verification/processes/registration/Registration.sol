// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IRegistration} from "./IRegistration.sol";
import {VerificationProcess} from "../VerificationProcess.sol";

abstract contract Registration is IRegistration, VerificationProcess {}
