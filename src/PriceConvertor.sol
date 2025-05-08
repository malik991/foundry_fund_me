// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConvertor {
    function getPrice(
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        //address get from caainlink price feed for ETH '0x694AA1769357215DE4FAC081bf1f309aDC325306'
        //ABI (get function from chainlink github repo )
        // AggregatorV3Interface priceFeed = AggregatorV3Interface(
        //     0x694AA1769357215DE4FAC081bf1f309aDC325306
        // );
        //get latest price data from chainlink
        //priceFeed.latestRoundData() --> 194718520 = 36,117 ETH (Ethereum) / roundID = 1 for now
        (
            ,
            /* uint80 roundId */ int256 price /*uint256 startedAt*/ /*uint256 updatedAt*/ /*uint80 answeredInRound*/,
            ,
            ,

        ) = priceFeed.latestRoundData(); // becuase latestRoundData return different value so we just need price at this time
        //*1 e18 means we want to get the usd value with unit in kilo
        // need casting price to uint256 bcz of decimal
        return uint256(price * 1e10); // this value is in ETH
    }

    // get version function for zkSync to show different address for different netwrok
    function getVersion(
        AggregatorV3Interface priceFeed
    ) public view returns (uint256) {
        // AggregatorV3Interface priceFeed = AggregatorV3Interface(
        //     0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF // eth/usd zksync address
        // );
        return priceFeed.version();
    }

    function getConversionRate(
        uint ethAmount,
        AggregatorV3Interface priceFeed
    ) internal view returns (uint256) {
        uint256 ethPrice = getPrice(priceFeed);
        // eth price 2000_000000000000000000
        // we need to get eth value * usd price / usd value = ethPrice
        // (1000000000000000000 * 2000_000000000000000000) / 1e18 = $2000 to get the value eth to usd whole number
        // $2000 = 1 Eth
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18;
        //emit EthReceived(ethAmountInUsd); // for console.log
        return ethAmountInUsd;
    }
}
