pragma solidity >=0.4.21 <0.6.0;

contract Ballot {

  string public proposal;

  constructor() public {
    proposal = "Proposal 1";
  }
}