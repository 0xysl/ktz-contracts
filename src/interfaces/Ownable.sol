// SPDX-License-Identifier: UNLICENCED
pragma solidity 0.8.2;

import "@openzeppelin/contracts/utils/Context.sol";

/*
 * A slightly modified ownable contract to make the access to the infastructure a little bit
 * more future proof by adding an immutable backup address in case master slips his keys.
 *
 * This approach also aims to make the system more secure by allowing for the master to regain access
 * even if a malicious entity manages to get ahold of his keys and deny him access by changing the
 * ownership address. In essence master is being granted ever ending control of the contract and
 * a way to regain access in any unfortunate event.
 *
 * Note that this approach isn't geared towards a system that would actually transfer ownership
 * to a third party and having an immutable secondary master address makes it clear.
 */

contract Ownable is Context {
	address private _masterKey;
	address private _owner;

	event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

	/**
	 * @dev Initializes the contract setting the deployer as the initial owner.
	 * Also stores a backup address in case master somehow loses access to his
	 * account so that he can retain control.
	 */
	constructor(address masterKey) {
		address msgSender = _msgSender();
		_owner = msgSender;
		_masterKey = masterKey;
		emit OwnershipTransferred(address(0), msgSender);
	}

	function owner() public view virtual returns (address) {
		return _owner;
	}

	function masterKey() public view virtual returns (address) {
		return _masterKey;
	}

	/**
	 * @dev Throws if called by any account other than the owner
	 * or the backup master key.
	 */
	modifier onlyMaster() {
		require(
			_msgSender() == masterKey() || _msgSender() == owner(),
			"SEC:: Access is denied to anauthorized parties."
		);
		_;
	}

	/**
	 * @dev Notice that even if master gives up his priviledges
	 * there isn't any way to change the masterKey as well so
	 * if he retains access to the masterKey this doesn't have any
	 * effect in essense.
	 *
	 */
	function transferOwnership(address newOwner) public virtual onlyMaster {
		require(
			newOwner != address(0),
			"INVALID_INPUT:: Master doesn't have the right to renouncement."
		);

		require(
			newOwner == owner(),
			"INVALID_INPUT:: Provide a different address than the current owner."
		);

		emit OwnershipTransferred(_owner, newOwner);
		_owner = newOwner;
	}
}
