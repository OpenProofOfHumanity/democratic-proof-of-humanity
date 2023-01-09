// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IRenweal} from "./IRenweal.sol";
import {VerificationProcess} from "../VerificationProcess.sol";

abstract contract Renweal is IRenweal, VerificationProcess {}
