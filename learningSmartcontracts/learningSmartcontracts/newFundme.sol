//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
// contract to send funds in usdc
// withdraw funds in usdc
// set a minimun values for users to send
// current contract costs 784248 gas would love to reduce it
// we will be doing this using the const and immutable keyword
// for state values you will not change you can add const to it

// we will be creating a library
// functions inside it will be internal

library priceConvertor {
     
    function getPrice() internal view  returns (uint256) {
    // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
    // ABI
    AggregatorV3Interface priceFeed = AggregatorV3Interface (0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
    ( ,int256 price, , , )= priceFeed.latestRoundData(); // returns price of eth in usd
    return uint256 (price * 1e10);
    } 

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        // ask for an eth, multiply by eth price in usd from get price and ensure everything in 1e18
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount)/1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256){
        return AggregatorV3Interface (0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
        

}


contract FundMe {
     using priceConvertor for uint256;
    
    address public immutable i_owner;// the owner variable

    uint256 public constant MINIMUM_USD=5e18; // because minimumUsd wont change we make it constant reducing gas
    address [] public funders;
    mapping ( address  => uint256 ) public addressToAmountFunded;

    function fund() public payable  {
            require(msg.value.getConversionRate()>=MINIMUM_USD, "Not enough ETH");
            funders.push(msg.sender);
            addressToAmountFunded[msg.sender]=addressToAmountFunded[msg.sender]+msg.value;
            
    }

    constructor () {
         i_owner=msg.sender;
    }
    
    function Withdraw() public onlyOwner{
        
        for (uint256 fundIndex= 0; fundIndex<funders.length; fundIndex++) 
        {
            address funder = funders[fundIndex];
            addressToAmountFunded[funder]=0;
             
        }
         //now we go ahead and reset the array

         funders= new address[] (0);

         // now we are goig to withdraw and we can do this with
         // transfer, call, or send

         //transfer
         //for this msg.sender is of type address
         // but to make it sendable we need to make it a payable address
         // transfer automatically reverts if transfer fails
         //payable(msg.sender).transfer(address(this).balance);

         //send 
         //for sending we will need a require statement with a bool
         // send does not return any notification
         //send doesnt automatically reverts if send fails thus we need a require statement to revert the transaction

        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess,"Failed to send ETH");

        //call
        // call returns two variables a bool and data from your call
        //call doesnt automatically reverts if send fails thus we need a require statement to revert the transaction
        // call is the most gas efficient function
         (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
         require(callSuccess,"Call Failed, Failed to send ETH");

    }

    modifier  onlyOwner (){
      require(msg.sender== i_owner, "You are not the owner"); // setting up the owner
    _;// underscore it the body or the code of the function you added the modifier too
    // if _; is before the code it runs it before it and if after it it runs the code before the modifier itself
    }

// what if someone sends a funds to a contract without our knowledge
// we can use recieve() for that and it can be used once
// must be external payabble and works when sender doest use fund in calldata
// fallback is either you call the wrong function or functio doesnt exist

receive() external payable { fund(); }
fallback() external payable { fund();}

}