
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

// import "./simplestorage.sol" [ this imports the entire file and it is not the best
// to import only one contract or multiple contracts

import {SimpleStorage, SimpleStorage2} from "./simplestorage.sol"; // this is the best way to import only one OR multiple  contract


// creating a new contract which will contain a function to deploy new SimpleStorage contracts
contract storagefactory{

  // [SimpleStorage public simplestorage;] we create a variable that can hold the address and use functions of the SimpleStorage
  
  //because we want to keep track of the addresses we made we want to store them in an array
   SimpleStorage[] public listofSimpleStorageContracts;
   function createSimpleStorageContract() public {
       listofSimpleStorageContracts.push (SimpleStorage(new SimpleStorage())); // push the address of the new contract into the arraynew SimpleStorage());
   }
   
   function sfdata (uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {

    //need the address and the ABI - Application Binary Interace

    //SimpleStorage mySimpleStorage = listofSimpleStorageContracts [_simpleStorageIndex];
    //mySimpleStorage.store(_newSimpleStorageNumber);
    listofSimpleStorageContracts [_simpleStorageIndex].store(_newSimpleStorageNumber);


   }
   
  function retrieve(uint256 _simpleStorageIndex) public view returns (uint256) {
    //SimpleStorage mySimpleStorage = listofSimpleStorageContracts[_simpleStorageIndex];
    //return mySimpleStorage.retrieve(); // Call the `retrieve` function from SimpleStorage
     return listofSimpleStorageContracts [_simpleStorageIndex].retrieve();
}
}