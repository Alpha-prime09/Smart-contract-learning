// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
import {priceConvertor} from "./ETHtoUSDpriceConverter.sol";



contract childCampaign {

using priceConvertor for uint256;
address public owner;
uint256 public constant MINIMUM_USD=5e18;

// initializing the contract owner which will be fed by the mother contract
constructor(address _owner){
    owner=_owner;
}

modifier matching(){
    require(msg.value.getConversionRate()>=MINIMUM_USD,"Not Enough ETH");
    _;
}

modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

modifier accessToWithdraw(){
    require(address(this).balance>0,"Not enough ETH");
    _;
}



address [] public listofFunders;
mapping (address=>uint256) public addressToAmountFunded;

function fundMe () public  payable matching{
    if (addressToAmountFunded[msg.sender] == 0) {
    listofFunders.push(msg.sender);}

    addressToAmountFunded[msg.sender]=addressToAmountFunded[msg.sender]+msg.value;
    
}

receive() external payable { fundMe();}
fallback() external payable { fundMe();}

function withdraw() public onlyOwner accessToWithdraw {

  for (uint256 fundindex=0; fundindex<listofFunders.length; fundindex++) 
  {
    address funder=listofFunders[fundindex];
    addressToAmountFunded[funder]=0;

  }

  listofFunders=new address[](0);

  (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
  require(callSuccess,"Call Failed, Failed to send ETH");

}


} 




