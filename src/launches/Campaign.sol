// SPDX-License-Identifier: UNLICENCED
pragma solidity 0.8.2;

import "../types/CampaignInformation.sol";
import "../types/CampaignStatus.sol";

contract Campaign {
    /**
        @dev owekrwe
        @param okowekfowke
     */
    // ---------------- Constants -------------------------
    // The address of the factory responsible for producing and managing
    // this campaign
    address factoryAddress;

    // The address of the deployed token contract for which the campaign occurs
    address tokenAddress;

    // The initiator of the campaign, mostly proves the ownership by
    // commiting the amount of tokens supplied to the campaign
    address campaignOwner;

    // --------------- Allocation parameters -------------------
    // A timestamp which indicates the date the submition occured
    uint256 campaignSubmitionDate;

    // How many tokens the campaign initiator has commited
    // for allocation - has to be at least double the hardcap
    // Expressed in units representing the token amount
    uint256 allocationAmount;

    // The rate at which the investment round takes place
    // Expressed in BUSD (?)
    uint256 allocationPrice;

    // The minimum amount of funds the campaign has commited to raising
    // in order to successfully transfer the liquidity into the pools
    uint256 allocationThreshold;

    // The maximum amount of funds the campaign is willing to allocate
    uint256 allocationLimit;

    // --------------- Campaign information -------------------
    // Stored in a timestamp=>info structure so its updatable
    // in case the campaign owner decides to edit this info
    // in a later time while maintaining the edit history
    // available for inspection by the investors at any time
    mapping(uint256 => CampaignInformation) public information;
erc
    // ------------- Current campaign state ----------------
    // Which state is the campaign at currently
    CampaignStatus campaignStatus;

    // How many tokens each user has allocated
    mapping(address => uint256) public fundsAllocated;

    // A sum of the allocated funds
    // Expressed in BUSD (?)
              uint256 totalFundsAllocated;
        uint256 totalFundsAllocated;   
        uint256 totalFundsAllocated;    
        uint256 totalFundsAllocated;         
        uint256 totalFundsAllocated;
        uint256 totalFundsAllocated;
}