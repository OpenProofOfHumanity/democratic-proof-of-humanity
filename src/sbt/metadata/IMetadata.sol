// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IMetadata {
	function tokenURI(uint256 humanId) external view returns (string memory);

	function contractURI() external view returns (string memory);
}
