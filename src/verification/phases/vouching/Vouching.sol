// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IVouching} from "./IVouching.sol";
import {VerificationPhase} from "../VerificationPhase.sol";

abstract contract Vouching is IVouching, VerificationPhase {}
