// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
    // If we are on a local Anvil, we deploy the mocks
    // Else, grab the existing address from the live network

    struct networkConfig {
        address priceFeedAddress;
    }
    networkConfig public activeNetworkConfig;

    constructor() {
        if (block.chainid == 11155111) {
            // Sepolia
            activeNetworkConfig = getSepoliaEthNetworkConfig();
        } else if (block.chainid == 31337) {
            // Anvil
            activeNetworkConfig = getAnvilEthNetworkConfig();
        } else {
            revert("No config for this network");
        }
    }

    function getSepoliaEthNetworkConfig()
        public
        pure
        returns (networkConfig memory)
    {
        networkConfig memory configSepolia = networkConfig({
            priceFeedAddress: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return configSepolia;
    }

    function getAnvilEthNetworkConfig()
        public
        pure
        returns (networkConfig memory)
    {
        // networkConfig memory config = networkConfig({
        //     priceFeedAddress:
        // })
    }
}
