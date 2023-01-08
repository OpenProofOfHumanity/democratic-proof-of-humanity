// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ISBT} from "./ISBT.sol";

contract SBT is ISBT, ERC721 {
	constructor() ERC721("Humanity Id", "HUMAN") {}

	function mint(uint256 humanId, address initialAddress) external {
		// pending: check msg.sender -> registration contract
		_safeMint(initialAddress, humanId);
	}

	function transfer(uint256 humanId, address newAddress) external {
		// pending: check msg.sender -> recovery contract
		_safeTransfer(ownerOf(humanId), newAddress, humanId, "");
	}
}
