// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import { IProofOfHumanity } from "./interfaces/IProofOfHumanity.sol";

error TransferFailed();

contract ProofOfHumanity {

  IProofOfHumanity public legacyProofOfHumanity;

  /* Constants and immutable */
  uint256 private constant RULING_OPTIONS = 2; // The amount of non 0 choices the arbitrator can give.
  uint256 private constant AUTO_PROCESSED_VOUCH = 10; // The number of vouches that will be automatically processed when executing a request.
  uint256 private constant FULL_REASONS_SET = 15; // Indicates that reasons' bitmap is full. 0b1111.
  uint256 private constant MULTIPLIER_DIVISOR = 10000; // Divisor parameter for multipliers.
  
  bytes32 private DOMAIN_SEPARATOR; // The EIP-712 domainSeparator specific to this deployed instance. It is used to verify the IsHumanVoucher's signature.
  bytes32 private constant IS_HUMAN_VOUCHER_TYPEHASH =
      0xa9e3fa1df5c3dbef1e9cfb610fa780355a0b5e0acb0fa8249777ec973ca789dc; // The EIP-712 typeHash of IsHumanVoucher. keccak256("IsHumanVoucher(address vouchedSubmission,uint256 voucherExpirationTimestamp)").

  /* Enums */

  enum Party {
      None, // Party per default when there is no challenger or requester. Also used for unconclusive ruling.
      Requester, // Party that made the request to change a status.
      Challenger // Party that challenged the request to change a status.
  }

  enum Reason {
      None, // No reason specified. This option should be used to challenge removal requests.
      IncorrectSubmission, // Request does not comply with the rules.
      Deceased, // Human has existed but does not exist anymore.
      Duplicate, // Human is already registered.
      DoesNotExist // Human is not real. For example, this can be used for videos showing computer generated persons.
  }

  enum Status {
      Vouching, // Request requires vouches / funding to advance to the next state. Should not be in this state for revokal requests.
      Resolving, // Request is resolving and can be challenged within the time limit.
      Disputed, // Request has been challenged.
      Resolved // Request has been resolved.
  }

  /* Structs */

  struct Request {
      bool disputed; // True if a dispute was raised. Note that the request can enter disputed state multiple times, once per reason.
      bool resolved; // True if the request is executed and/or all raised disputes are resolved.
      bool requesterLost; // True if the requester has already had a dispute that wasn't ruled in his favor.
      Reason currentReason; // Current reason a registration request was challenged with. Is left empty for removal requests.
      uint8 usedReasons; // Bitmap of the reasons used by challengers of this request.
      address payable requester; // Address that made a request. It is left empty for the registration requests since it matches submissionID in that case.
      address payable ultimateChallenger; // Address of the challenger who won a dispute. Users who vouched for the challenged submission must pay the fines to this address.
      address[] vouches; // Stores the addresses of submissions that vouched for this request and whose vouches were used in this request.
      mapping(uint256 => Challenge) challenges; // Stores all the challenges of this request. challengeID -> Challenge.
      mapping(address => bool) challengeDuplicates; // Indicates whether a certain duplicate address has been used in a challenge or not.
  }

  struct Submission {
      Status status; // The current status of the submission.
      bool registered; // Whether the submission is in the registry or not. Note that a registered submission won't have privileges (e.g. vouching) if its duration expired.
      bool hasVouched; // True if this submission used its vouch for another submission. This is set back to false once the vouch is processed.
      uint64 submissionTime; // The time when the submission was accepted to the list.
      uint64 index; // Index of a submission.
      Request[] requests; // List of status change requests made for the submission.
  }

  struct Round {
      // Some arrays below have 3 elements to map with the Party enums for better readability:
      // - 0: is unused, matches `Party.None`.
      // - 1: for `Party.Requester`.
      // - 2: for `Party.Challenger`.
      uint256[3] paidFees; // Tracks the fees paid by each side in this round.
      Party sideFunded; // Stores the side that successfully paid the appeal fees in the latest round. Note that if both sides have paid a new round is created.
      uint256 feeRewards; // Sum of reimbursable fees and stake rewards available to the parties that made contributions to the side that ultimately wins a dispute.
      mapping(address => uint256[3]) contributions; // Maps contributors to their contributions for each side.
  }

  struct Challenge {
      uint256 disputeID; // The ID of the dispute related to the challenge.
      Party ruling; // Ruling given by the arbitrator of the dispute.
      uint16 lastRoundID; // The ID of the last round.
      uint64 duplicateSubmissionIndex; // Index of a submission, which is a supposed duplicate of a challenged submission. It is only used for reason Duplicate.
      address payable challenger; // Address that challenged the request.
      mapping(uint256 => Round) rounds; // Tracks the info of each funding round of the challenge.
  }

  /* Storage */

  address public governor; // The address that can make governance changes to the parameters of the contract.
  uint256 public submissionBaseDeposit; // The base deposit to make a new request for a submission.
  // Note that to ensure correct contract behaviour the sum of challengePeriodDuration and renewalPeriodDuration should be less than submissionDuration.
  uint64 public submissionDuration; // Time after which the registered submission will no longer be considered registered. The submitter has to reapply to the list to refresh it.
  uint64 public renewalPeriodDuration; //  The duration of the period when the registered submission can reapply.
  uint64 public challengePeriodDuration; // The time after which a request becomes executable if not challenged. Note that this value should be less than the time spent on potential dispute's resolution, to avoid complications of parallel dispute handling.
  uint64 public requiredNumberOfVouches; // The number of registered users that have to vouch for a new registration request in order for it to enter PendingRegistration state.
  uint256 public sharedStakeMultiplier; // Multiplier for calculating the fee stake that must be paid in the case where arbitrator refused to arbitrate.
  uint256 public winnerStakeMultiplier; // Multiplier for calculating the fee stake paid by the party that won the previous round.
  uint256 public loserStakeMultiplier; // Multiplier for calculating the fee stake paid by the party that lost the previous round.
  uint256 public submissionCounter; // The total count of all submissions that made a registration request at some point. Includes manually added submissions as well.
  mapping(address => Submission) private submissions; // Maps the submission ID to its data. submissions[submissionID]. It is private because of getSubmissionInfo().
  mapping(address => mapping(address => bool)) public vouches; // Indicates whether or not the voucher has vouched for a certain submission. vouches[voucherID][submissionID].

  /* Modifiers */

  modifier onlyGovernor() {
      require(msg.sender == governor, "The caller must be the governor");
      _;
  }

  /* Events */

  /**
   *  @dev Emitted when a vouch is added.
   *  @param _submissionID The submission that receives the vouch.
   *  @param _voucher The address that vouched.
   */
  event VouchAdded(address indexed _submissionID, address indexed _voucher);

  /**
   *  @dev Emitted when a vouch is removed.
   *  @param _submissionID The submission which vouch is removed.
   *  @param _voucher The address that removes its vouch.
   */
  event VouchRemoved(address indexed _submissionID, address indexed _voucher);

  /** @dev Emitted when the request to add a submission to the registry is made.
   *  @param _submissionID The ID of the submission.
   *  @param _requestID The ID of the newly created request.
   */
  event AddSubmission(address indexed _submissionID, uint256 _requestID);

  /** @dev Emitted when the reapplication request is made.
   *  @param _submissionID The ID of the submission.
   *  @param _requestID The ID of the newly created request.
   */
  event ReapplySubmission(address indexed _submissionID, uint256 _requestID);

  /** @dev Emitted when the removal request is made.
   *  @param _requester The address that made the request.
   *  @param _submissionID The ID of the submission.
   *  @param _requestID The ID of the newly created request.
   */
  event RemoveSubmission(address indexed _requester, address indexed _submissionID, uint256 _requestID);

  /** @dev Emitted when the submission is challenged.
   *  @param _submissionID The ID of the submission.
   *  @param _requestID The ID of the latest request.
   *  @param _challengeID The ID of the challenge.
   */
  event SubmissionChallenged(address indexed _submissionID, uint256 indexed _requestID, uint256 _challengeID);

  /** @dev Emitted when someone contributes to the appeal process.
   *  @param _submissionID The ID of the submission.
   *  @param _challengeID The index of the challenge.
   *  @param _party The party which received the contribution.
   *  @param _contributor The address of the contributor.
   *  @param _amount The amount contributed.
   */
  event AppealContribution(
      address indexed _submissionID,
      uint256 indexed _challengeID,
      Party _party,
      address indexed _contributor,
      uint256 _amount
  );

  /** @dev Emitted when one of the parties successfully paid its appeal fees.
   *  @param _submissionID The ID of the submission.
   *  @param _challengeID The index of the challenge which appeal was funded.
   *  @param _side The side that is fully funded.
   */
  event HasPaidAppealFee(address indexed _submissionID, uint256 indexed _challengeID, Party _side);

  /** @dev Emitted when the challenge is resolved.
   *  @param _submissionID The ID of the submission.
   *  @param _requestID The ID of the latest request.
   *  @param _challengeID The ID of the challenge that was resolved.
   */
  event ChallengeResolved(address indexed _submissionID, uint256 indexed _requestID, uint256 _challengeID);


  /** @dev Constructor.
   *  @param _legacyProofOfHumanity The legacy Proof of Humanity contract. 
   *  @param _submissionBaseDeposit The base deposit to make a request for a submission.
   *  @param _submissionDuration Time in seconds during which the registered submission won't automatically lose its status.
   *  @param _renewalPeriodDuration Value that defines the duration of submission's renewal period.
   *  @param _challengePeriodDuration The time in seconds during which the request can be challenged.
   *  @param _multipliers The array that contains fee stake multipliers to avoid 'stack too deep' error.
   *  @param _requiredNumberOfVouches The number of vouches the submission has to have to pass from Vouching to PendingRegistration state.
   */
  constructor(
      IProofOfHumanity _legacyProofOfHumanity,
      uint256 _submissionBaseDeposit,
      uint64 _submissionDuration,
      uint64 _renewalPeriodDuration,
      uint64 _challengePeriodDuration,
      uint256[3] memory _multipliers,
      uint64 _requiredNumberOfVouches
  ) {
      governor = msg.sender;
      legacyProofOfHumanity = _legacyProofOfHumanity;
      submissionBaseDeposit = _submissionBaseDeposit;
      submissionDuration = _submissionDuration;
      renewalPeriodDuration = _renewalPeriodDuration;
      challengePeriodDuration = _challengePeriodDuration;
      sharedStakeMultiplier = _multipliers[0];
      winnerStakeMultiplier = _multipliers[1];
      loserStakeMultiplier = _multipliers[2];
      requiredNumberOfVouches = _requiredNumberOfVouches;

      // EIP-712.
      bytes32 DOMAIN_TYPEHASH = 0x8cad95687ba82c2ce50e74f7b754645e5117c3a5bec8151c0726d5857980a866; // keccak256("EIP712Domain(string name,uint256 chainId,address verifyingContract)").
      DOMAIN_SEPARATOR = keccak256(
          abi.encode(DOMAIN_TYPEHASH, keccak256("Proof of Humanity"), block.chainid, address(this))
      );
  }
}
