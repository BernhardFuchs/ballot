pragma solidity >=0.4.21 <0.6.0;

contract Ballot {

  struct Proposal {
    uint id;
    string name;
    uint voteCount;
  }

  // Fetch Proposals
  mapping(uint => Proposal) public proposals;
  // Store Proposals count
  uint public proposalsCount;

  constructor() public {
    addProposal("Proposal 1");
    addProposal("Proposal 2");
  }

  function addProposal (string memory _proposal) private {
    proposalsCount ++;
    proposals[proposalsCount] = Proposal(proposalsCount, _proposal, 0);
  }
}