// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract FundMeScript is Script {
    function run() external returns (FundMe) {
        // The next line runs before the vm.startBroadcast() is called
        // This will not be deployed because the `real` signed txs are happening
        // between the start and stop Broadcast lines.
        HelperConfig helperConfig = new HelperConfig(); // saving cost before startBroadcast
        // This is the address of the price feed contract
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        //FundMe fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        console.log("FundMe deployed to: ", address(fundMe));
        vm.stopBroadcast();
        return fundMe;
    }
}
