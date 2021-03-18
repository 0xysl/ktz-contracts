// SPDX-License-Identifier: UNLICENCED
pragma solidity 0.8.2;

import { CampaignInfo, CampaignData } from "../types/Campaign.sol";
import { FactorySpecs } from "../types/Factory.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

function validateCampaignInput(
	CampaignData memory data,
	CampaignInfo memory info,
	FactorySpecs memory requirements
) view returns (bool) {
	require(validateData(data, requirements));
	require(validateInfo(info));

	return true;
}

function validateData(CampaignData memory data, FactorySpecs memory requirements)
	view
	returns (bool)
{
	require(
		IERC20(requirements.ktzAddress).balanceOf(msg.sender) >
			requirements.participationAmountThreshold,
		"DATA_VALIDATION:: You do not meet the minimum KtzToken amount required."
	);

	uint256 totalAllocation = data.tokensCommited * data.allocationRate;

	require(
		requirements.minimumLockTime < data.lockPeriod,
		"DATA_VALIDATION:: You must provide a minimum lock period greater than specified."
	);

	require(
		requirements.minAmountAllowedToRaise < totalAllocation,
		"DATA_VALIDATION:: You do not meet the allocation amount required."
	);

	require(
		requirements.maxAmountAllowedToRaise > totalAllocation,
		"DATA_VALIDATION:: You do not meet the allocation amount required."
	);

	require(
		data.allocationRate != 0,
		"DATA_VALIDATION:: You must provide a valid allocation rate greater than zero."
	);

	return true;
}

function validateInfo(CampaignInfo memory info) pure returns (bool) {
	require(
		bytes(info.title).length > 0,
		"INFO_VALIDATION:: Please provide a valid campaign title."
	);

	require(
		bytes(info.subTitle).length > 0,
		"INFO_VALIDATION:: Please provide a valid campaign subtitle."
	);

	require(
		bytes(info.description).length > 0,
		"INFO_VALIDATION:: Please provide a valid campaign description."
	);

	require(
		bytes(info.website).length > 0,
		"INFO_VALIDATION:: Please provide a valid campaign subtitle."
	);

	return true;
}
