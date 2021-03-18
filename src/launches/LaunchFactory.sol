// SPDX-License-Identifier: UNLICENCED
pragma solidity 0.8.2;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { AccessControlled } from "../libs/AccessControlled.sol";
import { Campaign } from "./Campaign.sol";
import { CampaignInfo, CampaignData } from "../types/Campaign.sol";
import { validateCampaignInput } from "../validators/Campaign.sol";

import { KtzToken } from "../KtzToken.sol";

contract LaunchFactory is AccessControlled {
	// -------------- Access Control -----------------
	address private _masterAddress;
	address private _masterAddressBackup;

	// -------------- Constants -----------------
	address public pancakeswapRouter;
	KtzToken public ktzToken;

	// -------------- Internals -----------------
	// Variables that represent the factory's state
	address public launchContract;
	mapping(address => Campaign) public campgains;

	//  -------------- Contraints -----------------
	//  Variables to make sure that campaign launches
	//  occur within certain acceptable ranges

	// The minimum amount of tokens a willing campaign launcher
	// should own in order to participate. The purpose of this is
	// to act as another measure against possible attack vectors
	// like spamming the candidate list without actually increasing
	// the entry barrier for the project owners as they can sell the
	// tokens at anytime after their listing is submitted.
	uint256 participationAmountThreshhold;

	// The minimum and maximum amount that a campaign can raise,
	// expressed in usd - most prominent stable of each network.
	uint256 minAmountAllowedToRaise;
	uint256 maxAmountAllowedToRaise;

	// The minimum amount of time the owner is allowed to lock
	// the liquidity for.
	uint256 minimumLockTime;

	// Time required before picking the next n nominees to list
	// based on the amount of votes each aquired. Expressed in seconds.
	uint256 nominationRoundInterval;

	// The amount of candidates that will get listed after each
	// nomination round elapsed.
	uint256 numberOfNomineesToList;

	// How long each campaign can stay as listing nominee before
	// it becomes obsolete. Expressed in seconds.
	uint256 durationBeforeBecommingObsolete;

	constructor(address masterAddress, address masterAddressBackup) {
		_masterAddress = masterAddress;
		_masterAddressBackup = masterAddressBackup;
	}

	function createCampaign(CampaignData memory campaignData, CampaignInfo memory campaignInfo)
		public
		returns (address)
	{
		

		require(validateCampaignInput(campaignData, campaignInfo));
		Campaign campaign = deployCampaign(campaignData.tokenAddress);
		campaign.initializeData(campaignData, campaignInfo, msg.sender);
		require(transferTokensCommited(campaign, campaignData.tokensCommited));

		return address(campaign);
	}

	function deployCampaign(address token) internal returns (Campaign) {
		bytes memory bytecode = type(KtzToken).creationCode;
		bytes32 salt = keccak256(abi.encodePacked(token, msg.sender));

		address campaignAddress;

		assembly {
			campaignAddress := create2(0, add(bytecode, 32), mload(bytecode), salt)
		}

		return Campaign(campaignAddress);
	}

	function transferTokensCommited(Campaign campaign, uint256 amountCommited)
		internal
		returns (bool)
	{
		require(
			ktzToken.transferFrom(msg.sender, address(campaign), amountCommited),
			"ERROR:: Tokens commited failed to transfer to the contract address."
		);
		return true;
	}

	function updateLaunchContract(address _launchContract) external onlyMaster {
		require(
			_launchContract != address(this),
			"INVALID_INPUT:: Supplied implementation address doesn't differ from the one already in use."
		);

		launchContract = _launchContract;
	}
}
