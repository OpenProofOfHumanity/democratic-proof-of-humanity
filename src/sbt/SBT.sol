// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import {ISBT} from "./ISBT.sol";
import {IMetadata} from "./metadata/IMetadata.sol";
import {Counters} from "@openzeppelin/contracts/utils/Counters.sol";

import {RequestType} from "../data-structures/RequestType.sol";

import {NotHumanID, UnauthorizedTransfer, InvalidSender} from "../data-structures/Errors.sol";

contract SBT is ISBT, ERC721 {
	using Counters for Counters.Counter;

	IMetadata private _metadata;

	Counters.Counter private _tokenCounter;

	// reverse of ownerOf(uint256)
	mapping(address => uint256) _humanIds;

	mapping(RequestType => address) private _verificationContracts;

	modifier onlyVerificationContract(RequestType requestType) {
		if (msg.sender != _verificationContracts[requestType]) revert InvalidSender(msg.sender);
		_;
	}

	constructor(address initialMetadataContract) ERC721("Humanity Id", "HUMAN") {
		_metadata = IMetadata(initialMetadataContract);
	}

	function mint(uint256 humanId, address initialAddress) external {
		// pending: check msg.sender -> registration contract
		_safeMint(initialAddress, humanId);
	}

	function transfer(uint256 humanId, address newAddress) external {
		// pending: check msg.sender -> recovery contract
		_safeTransfer(ownerOf(humanId), newAddress, humanId, "");
	}

	function updateMetadataImplementation(address _contract) external {
		// pending: check msg.sender -> governor
		_metadata = IMetadata(_contract);
	}

	function tokenURI(uint256 humanId) public view override returns (string memory) {
		if (!_exists(humanId)) revert NotHumanID(humanId);
		return _metadata.tokenURI(humanId);
	}

	function contractURI() external view returns (string memory) {
		return _metadata.contractURI();
	}

	function metadataContract() external view returns (address) {
		return address(_metadata);
	}

	function humanIdOf(address human) external view returns (uint256) {
		return _humanIds[human];
	}

	function isHuman(uint256 humanId) external view returns (bool) {
		return _exists(humanId);
	}

	function isHuman(address human) external view returns (bool) {
		return _humanIds[human] != 0;
	}

	// Non open transferability

	function transferFrom(address, address, uint256) public virtual override(ERC721, IERC721) {
		revert UnauthorizedTransfer();
	}

	function safeTransferFrom(address, address, uint256) public virtual override(ERC721, IERC721) {
		revert UnauthorizedTransfer();
	}

	function safeTransferFrom(address, address, uint256, bytes memory) public virtual override(ERC721, IERC721) {
		revert UnauthorizedTransfer();
	}

	function approve(address, uint256) public virtual override(ERC721, IERC721) {
		revert UnauthorizedTransfer();
	}

	function setApprovalForAll(address, bool) public virtual override(ERC721, IERC721) {
		revert UnauthorizedTransfer();
	}
}
