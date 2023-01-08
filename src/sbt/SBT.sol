// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ISBT} from "./ISBT.sol";
import {IMetadata} from "./metadata/IMetadata.sol";

error NotHuman();

contract SBT is ISBT, ERC721 {
	IMetadata private _metadata;

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
		if (!_exists(humanId)) revert NotHuman();
		return _metadata.tokenURI(humanId);
	}

	function contractURI() external view returns (string memory) {
		return _metadata.contractURI();
	}

	function metadataContract() external view returns (address) {
		return address(_metadata);
	}
}
