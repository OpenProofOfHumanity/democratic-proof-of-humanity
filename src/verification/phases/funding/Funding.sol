// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IFunding} from "./IFunding.sol";
import {VerificationPhase} from "../VerificationPhase.sol";

abstract contract Funding is IFunding, VerificationPhase {}
