// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {IERC721} from "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface ISBT is IERC721 {
	function mint(uint256 humanId, address initialAddress) external;

	function transfer(uint256 humanId, address newAddress) external;

	function contractURI() external view returns (string memory);

	function metadataContract() external view returns (address);

	function updateMetadataImplementation(address _contract) external;

	function isHuman(uint256 humanId) external view returns (bool)
}
