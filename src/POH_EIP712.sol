// SPDX-License-Identifier: MIT
pragma solidity 0.8.14;

import {EIP712} from "@openzeppelin/contracts/utils/cryptography/EIP712.sol";
import {ECDSA} from "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

struct Signature {
	uint8 v;
	bytes32 r;
	bytes32 s;
}

contract POH_EIP712 is EIP712 {
	bytes32 private constant _HUMANITY_VOUCHER_TYPEHASH =
		keccak256("HumanityVoucher(address vouchedHuman,uint256 deadline)");

	constructor() EIP712("Proof of Humanity", "2") {}

	function DOMAIN_SEPARATOR() external view returns (bytes32) {
		return _domainSeparatorV4();
	}

	function recoverVoucherSigner(
		address vouchedHuman,
		uint256 deadline,
		Signature calldata signature
	) public view returns (address signer) {
		bytes32 structHash = keccak256(abi.encode(_HUMANITY_VOUCHER_TYPEHASH, vouchedHuman, deadline));

		signer = _hashSigner(structHash, signature);
	}

	function _hashSigner(bytes32 structHash, Signature calldata signature) private view returns (address signer) {
		return ECDSA.recover(_hashTypedDataV4(structHash), signature.v, signature.r, signature.s);
	}
}
