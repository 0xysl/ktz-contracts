// SPDX-License-Identifier: UNLICENCED
pragma solidity 0.8.2;

import "../interfaces/Ownable.sol";
contract LaunchFactory is Ownable {

    // -------------- Constants -----------------
    address public pancakeswapRouter;
    address public ktzAddress;

    // -------------- Internals -----------------
    // Variables that represent the factory's state
    address private master;
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

    // Time required before picking the next n nominees to list
    // based on the amount of votes each aquired.
    // Expressed in seconds.
    uint256 nominationRoundInterval;

    // The amount of candidates that will get listed after each
    // nomination round elapsed.
    uint256 numberOfNomineesToList;

    // How long each campaign can stay as listing nominee before
    // it becomes obsolete. Expressed in seconds.
    uint256 durationBeforeBecommingObsolete;

    function updateLaunchContract(address _launchContract) external onlyMaster {
        require(
            _launchContract != address(this),
            "INVALID_INPUT:: Supplied implementation address doesn't differ from the one already in use."
        );

        launchContract = _launchContract;
    }
}
