
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

contract SimpleStorage {

// intitializing number and if you dont assign a vaue it is given 0 automatically
uint256 public number; 

//creating a tempplate for adding a new person and each person has a name and fav number
struct People {
    uint256 favoriteNumber;
    string name;
 }

// we initialize the person by creating Person which will hold the name and fav number
People public person = People({favoriteNumber: 2, name: "Bhargav"});

// we create a list to hold our persons
People[] public listofpersons;

// we create a map such that a name -> number ( name would return a number)
mapping ( string => uint256) public nameToFavNumber;


// we would like a function call to add a person for us and assign the name to a number
function addperson (string memory _name, uint256 _favnumber) public {
    listofpersons.push(People({favoriteNumber: _favnumber, name: _name}));
    nameToFavNumber[_name]= _favnumber; //assign the name to a number using the mapping
}


function store (uint256 _num) public {
    number= _num;
}



// when you use view, pure it becomes only read
function retrieve() public view returns (uint256) {
    return number;

}
}


// creating a new contract which will contain a function to deploy new SimpleStorage contracts
contract storagefactory{

   SimpleStorage public simplestorage; // we create a variable that can hold the address and use functions of the SimpleStorage

   function createSimpleStorageContract() public {
       simplestorage = new SimpleStorage(); // intitialize a new SimpleStorage contract 
   }


}