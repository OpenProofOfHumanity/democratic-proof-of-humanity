// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ProofOfHumanity.sol";
import "./mocks/MockERC20.sol";

contract TestContract is Test {
    ProofOfHumanity public proofOfHumanity;
    MockERC20 public mockToken;
    ErrorsTest test;

    function setUp() public {
        proofOfHumanity = new ProofOfHumanity();
        mockToken = new MockERC20();
        test = new ErrorsTest();
    }

    function testExample() public {
      uint256 amount = 10e18;
      mockToken.approve(address(proofOfHumanity), amount);
      bool passed = proofOfHumanity.stake(amount, address(mockToken));
      assertTrue(passed);
    }

    function testExpectArithmetic() public {
        vm.expectRevert(stdError.arithmeticError);
        test.arithmeticError(10);
    }
}

contract ErrorsTest {
    function arithmeticError(uint256 a) public {
        uint256 a = a - 100;
    }
}