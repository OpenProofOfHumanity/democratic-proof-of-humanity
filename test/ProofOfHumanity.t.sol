// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ProofOfHumanity.sol";
import "./mocks/MockERC20.sol";
import "./utils/Cheats.sol";

contract TestContract is Test {
    Cheats internal constant cheats = Cheats(HEVM_ADDRESS);
    ProofOfHumanity public proofOfHumanity;
    MockERC20 public mockToken;

    function setUp() public {
        proofOfHumanity = new ProofOfHumanity();
        mockToken = new MockERC20();
    }

    function testStake() public {
      uint256 amount = 10e18;
      mockToken.approve(address(proofOfHumanity), amount);
      cheats.roll(55);
      bool passed = proofOfHumanity.stake(amount, address(mockToken));
      assertTrue(passed);
    }
}
