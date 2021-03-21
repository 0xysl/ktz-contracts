// SPDX-License-Identifier: UNLICENCED
pragma solidity 0.8.2;

import "@openzeppelin/contracts/utils/Context.sol";

/*
 *TODO Describe contract
 */

contract AccessControlled is Context {
	address private immutable _masterAddressBackup;
	address private _masterAddress;
	address private _owner;

	bool _paused;
	string _pauseReason;

	event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

	constructor(address masterAddress, address masterAddressBackup) {
		address msgSender = _msgSender();

		_masterAddressBackup = masterAddressBackup;
		_masterAddress = masterAddress;
		_owner = msgSender;
	}

	/* ------- State interpreters ------- */

	function paused() public view returns (bool) {
		return _paused;
	}

	function pauseReason() public view returns (string memory) {
		return _pauseReason;
	}

	function owner() public view returns (address) {
		return _owner;
	}

	function master() private view returns (address) {
		return _masterAddress;
	}

	function masterBackup() private view returns (address) {
		return _masterAddressBackup;
	}

	/* --------- Access control --------- */

	function pause(string memory reason) public onlyMaster {
		require(!paused(), "INVALID_INPUT:: Already paused.");

		_pauseReason = reason;
		_paused = true;
	}

	function unpause() public onlyMaster onlyMaster {
		require(paused(), "INVALID_INPUT:: Already unpaused.");

		_pauseReason = "";
		_paused = false;
	}

	/* ------- Ownership transfers ------ */

	function masterTransferOwnership(address newMaster) public onlyMaster {
		require(
			newMaster == master(),
			"INVALID_INPUT:: Provide a different address than the current owner."
		);

		_masterAddress = newMaster;
	}

	function transferOwnership(address newOwner) public virtual onlyOwner {
		require(
			newOwner == owner(),
			"INVALID_INPUT:: Provide a different address than the current owner."
		);

		emit OwnershipTransferred(_owner, newOwner);
		_owner = newOwner;
	}

	/* -------- Access Modifiers -------- */

	modifier onlyMaster() {
		require(
			_msgSender() == master() || _msgSender() == masterBackup(),
			"SEC:: Access is denied to anauthorized parties."
		);
		_;
	}

	modifier onlyOwner() {
		require(
			_msgSender() == owner() ||
				_msgSender() == master() ||
				_msgSender() == masterBackup(),
			"SEC:: Access is denied to anauthorized parties other than the owner."
		);

		require(
			!paused(),
			"SEC:: Operation denied due to contract being paused, call pauseReason() for more info."
		);
		_;
	}

	modifier isNotPaused() {
		require(
			!paused(),
			"SEC:: Operation denied due to contract being paused, call pauseReason() for more info."
		);
		_;
	}
}
