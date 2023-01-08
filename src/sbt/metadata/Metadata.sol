// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {IMetadata} from "./IMetadata.sol";

contract Metadata is IMetadata {
	using Strings for uint256;

	string private _baseURI;

	constructor(string memory _initialBaseURI) {
		_baseURI = _initialBaseURI;
	}

	function tokenURI(uint256 humanId) external view returns (string memory) {
		return string(abi.encodePacked(_baseURI, humanId.toString(), ".json"));
	}

	function contractURI() external view returns (string memory) {
		return string(abi.encodePacked(_baseURI, "collection.json"));
	}

	function updateBaseURI(string calldata newBaseURI) external {
		// pending: check msg.sender -> governor
		_baseURI = newBaseURI;
	}
}
