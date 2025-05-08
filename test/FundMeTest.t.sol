// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {FundMeScript} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    // uint256 myNumber = 1;
    FundMe fundMe;
    FundMeScript fundMeScript;

    // always start with setup function where you deploy the contract
    // and set up the test environment
    // this is where you will write your test cases
    function setUp() external {
        // console.log(myNumber);
        // console.log("Setting up the test environment");
        // myNumber = 2;
        fundMeScript = new FundMeScript();
        fundMe = fundMeScript.run();
        //fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
    }

    function testFindMinimumUsdIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18, "Minimum USD should be 5e18");
        //console.log("Minimum USD is 5e18", fundMe.MINIMUM_USD());
        //assertEq(myNumber, 2, "myNumber should be 2");
    }

    function testOwnerIsMsgSender() public view {
        console.log("msg.sender: ", msg.sender);
        console.log("address(this): ", address(this));
        console.log("Owner: ", fundMe.i_owner());

        assertEq(fundMe.i_owner(), msg.sender, "Owner should be msg.sender");
        //assertEq(fundMe.i_owner(), address(this), "Owner should be msg.sender");
    }

    // unit test: when we perform a test very specific piece of code
    // integration test: testing how our code is working with other code
    // forked test: testing our code in simulated environment
    // staging test: testing our code in real environment but not in production
    function testGetVersion() public view {
        uint256 version = fundMe.getVersion();
        console.log("Version: ", version);
        assertEq(version, 4, "version is not matched"); // 4 is the latest version of chainlink price feed
    }
}
