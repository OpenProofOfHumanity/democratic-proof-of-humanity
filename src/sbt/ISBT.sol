// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface ISBT is IERC721 {
	function mint(uint256 humanId, address initialAddress) external;

	function transfer(uint256 humanId, address newAddress) external;
}
