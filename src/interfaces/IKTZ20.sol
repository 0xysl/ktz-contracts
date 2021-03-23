// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
	An interface that combines both the BEP20 and the ERC20 standard.
 */
interface IKTZ20 is IERC20 {
	/**
	 * @dev Returns the token decimals.
	 */
	function decimals() external view returns (uint8);

	/**
	 * @dev Returns the token symbol.
	 */
	function symbol() external view returns (string memory);

	/**
	 * @dev Returns the token name.
	 */
	function name() external view returns (string memory);

	/**
	 * @dev Returns the bep token owner.
	 */
	function getOwner() external view returns (address);

	/**
		The following declarations are ommited as they're part of the original ERC20 standard aswell.
	 */

	// function totalSupply() external view returns (uint256);
	// function balanceOf(address account) external view returns (uint256);
	// function transfer(address recipient, uint256 amount) external returns (bool);
	// function allowance(address _owner, address spender) external view returns (uint256);
	// function approve(address spender, uint256 amount) external returns (bool);
	// function transferFrom(
	// 	address sender,
	// 	address recipient,
	// 	uint256 amount
	// ) external returns (bool);
	// event Transfer(address indexed from, address indexed to, uint256 value);
	// event Approval(address indexed owner, address indexed spender, uint256 value);
}
