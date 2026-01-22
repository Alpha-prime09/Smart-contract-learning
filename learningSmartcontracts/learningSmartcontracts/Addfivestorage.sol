

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {SimpleStorage} from "./simplestorage.sol";

contract Addperson is SimpleStorage{ // Addperson is inheriting from Simplestorage
  // we would love to do overrides, which is to override a function from the parent
  //we would need an override and virtual button to do this.

  function store(uint256 _newNum) public override {
     number= _newNum+5;
  }
}