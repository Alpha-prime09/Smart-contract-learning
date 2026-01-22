// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {childCampaign} from "./childTemplate.sol";

contract motherCampaign{

    address public  immutable owner;
// Initializing the owner of the contract at deployment
    constructor(){
        owner=msg.sender;
    }
    
     modifier onlyOwner(){
        require(msg.sender==owner,"Only owner can call this function");
        _;
    }

    
    address[] public listofChildAddress;
    


    function createChild() public onlyOwner {

        childCampaign newChild = new childCampaign(msg.sender);
        listofChildAddress.push(address(newChild));
        
    }
    
    function getChildAddress(uint256 _index) public view returns(address){
        return listofChildAddress[_index];
    }

    function trackCampaign() public view returns (uint256){
        return listofChildAddress.length;
    }

}