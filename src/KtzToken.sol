// SPDX-License-Identifier: UNLICENCED
pragma solidity 0.8.2;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/Ownable.sol";

contract KtzToken is IERC20, Ownable {
	string public constant name = "Ktz Token";
	string public constant symbol = "KTZ";
	string public constant version = "1";
	uint8 public constant decimals = 18;
	address private _masterKey;

	constructor(address masterKey) Ownable(masterKey) {
		_masterKey = masterKey;
	}

	
}
