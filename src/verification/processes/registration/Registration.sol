// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IRegistration} from "./IRegistration.sol";
import {VerificationProcess} from "../VerificationProcess.sol";

contract Registration is IRegistration, VerificationProcess {}
