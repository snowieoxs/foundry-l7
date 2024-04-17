// SPDX-License-Identifier: MIT

// Fund
// Withdraw

pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    function fundFundMe(address mostRecentlyDeployed) public {
        // vm.startBroadcast(); // removed @ 11.34
        FundMe(payable(mostRecentlyDeployed)).fund{value: SEND_VALUE}();
        // vm.stopBroadcast(); // remove @ 11.34
        console.log("Funded FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        vm.startBroadcast(); // moved @ 11.34
        fundFundMe(mostRecentlyDeployed);
        vm.stopBroadcast(); // moved @ 11.34
    }
}

contract WithdrawFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    function withdrawFundMe(address mostRecentlyDeployed) public {
        vm.startBroadcast(); // added @ 13.26
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast(); // added @ 13.26
        console.log("Withdrawn FundMe contract with: %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe",
            block.chainid
        );
        // vm.startBroadcast(); // removed @ 13.27
        withdrawFundMe(mostRecentlyDeployed);
        // vm.stopBroadcast(); // removed @ 13.27
    }
}

// 13.06
