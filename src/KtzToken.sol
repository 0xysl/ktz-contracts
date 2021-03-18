// SPDX-License-Identifier: UNLICENCED
pragma solidity 0.8.2;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./libs/AccessControlled.sol";

contract KtzToken is IERC20, AccessControlled {
	string public constant name = "Ktz Token";
	string public constant symbol = "KTZ";
	string public constant version = "1";
	uint8 public constant decimals = 18;

	uint256 public totalSupply;
	uint256 initialSupply = 10e17;
	mapping(address => mapping(address => uint256)) public allowances;

	address private _masterKey;
	mapping(address => uint256) public balances;

	constructor() {
		balances[msg.sender] = initialSupply;
		totalSupply = initialSupply;
	}

	function transfer(address to, uint256 value) public override returns (bool success) {
		require(
			balances[msg.sender] >= value,
			"INVALID_INPUT:: The transaction amount exceeds your balance."
		);

		balances[msg.sender] -= value;
		balances[to] += value;

		emit Transfer(msg.sender, to, value);
		return true;
	}

	function transferFrom(
		address from,
		address to,
		uint256 value
	) public override returns (bool success) {
		uint256 allowance = allowances[from][msg.sender];
		require(
			balances[from] >= value && allowance >= value,
			"INVALID_INPUT:: Allowance limit exceeded."
		);

		balances[to] += value;
		balances[from] -= value;
		allowances[from][msg.sender] -= value;

		emit Transfer(from, to, value);
		return true;
	}

	function balanceOf(address owner) public view override returns (uint256 balance) {
		return balances[owner];
	}

	function approve(address spender, uint256 value) public override returns (bool success) {
		allowances[msg.sender][spender] = value;
		emit Approval(msg.sender, spender, value);
		return true;
	}

	function allowance(address owner, address spender)
		public
		view
		override
		returns (uint256 remaining)
	{
		return allowances[owner][spender];
	}
}
