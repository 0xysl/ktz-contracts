// SPDX-License-Identifier: UNLICENCED
pragma solidity 0.8.2;

enum CampaignStatus {
    // As long as the campaign hasn't exceeded the durationAllowedBeingANominee
    // and is currently a nominee for the next listings
    NOMINEE,
    // The campaign is currently being listed and is actively raising funds
    LISTED,
    // The campaign has met the desired allocation before its deadline
    // and has launched suffessfully
    SUCCESSFUL,
    // The campaign has failed to meet the softcap after durationBeforeBecommingObsolete
    // time and is deemed failed which causes the campaign to phase out both from
    // active listings as well as listing nominees
    FAILED,
    // The campaign didn't manage to be included for listing and has surpassed the
    // durationBeforeBecommingObsolete and didn't manage to gather enough votes by
    // the community in order to be within the top numberOfNomineesToList which got listed
    // Any funds invested should be returned back to their respective owners before this status is granted
    OBSOLETE,
    // The campaign has been paused by the master most likely due to investigation
    // of possibly fraudulent intentions. Should rarely, if ever triggered as the community
    // is the one responsible for doing its own due dilligence and picking the projects which
    // they have researched to be suitable for them to invest into
    PAUSED,
    // The campaign has proven to be of fraudulent nature and action has
    // been taken against that. Similar to pause this can only be called by the master
    // only in extreme cases
    // Any funds invested should be returned back to their respective owners before this status is granted
    BANNED
}
