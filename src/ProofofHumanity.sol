// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/interfaces/IERC20.sol";

contract ProofofHumanity {

  // Set up the ERC20 token
  IERC20 private _token;
  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupply;

  // Set up the registry
  struct Human {
      string name;
      string description;
      uint256 applicationDate;
      uint256 voteBy;
      bool accepted;
      uint256 deposit;
  }
  mapping(uint256 => Human) public humans;
  uint256 public humanCount;

  // Set up the parameters for the registry
  uint256 public minDeposit;
  uint256 public applyStageLength;
  uint256 public votingStageLength;
  uint256 public minQuorum;
  uint256 public voteQuorum;
  uint256 public votingPeriodLength;

  // Set up the contract owner and the curator
  address public owner;
  address public curator;

  // Set up the events
  event HumanAdded(uint256 indexed humanId, string name, string description, uint256 deposit);
  event HumanRemoved(uint256 indexed humanId, string name, string description, uint256 deposit);
  event HumanAccepted(uint256 indexed humanId, string name, string description, uint256 deposit);
  event HumanRejected(uint256 indexed humanId, string name, string description, uint256 deposit);

  constructor(
      address _curator,
      IERC20 _token
  ) public {
      // Set the owner and curator
      owner = msg.sender;
      curator = _curator;

      // Set up the ERC20 token
      _token = _token;
  }

  // Function to add a human to the registry
  function addHuman(string memory name, string memory description) public payable {
      require(msg.value >= minDeposit, "Deposit insufficient");
  }
}
