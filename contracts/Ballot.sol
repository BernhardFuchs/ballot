pragma solidity >=0.4.21 <0.6.0;

contract Ballot {

    struct Voter {
        uint weight;
        bool voted;
        uint8 vote;
        address delegate;
    }
    struct Proposal {
        uint id;
        string settingsHash;
        uint voteCount;
    }

    address admin;
    mapping(address => Voter) voters;
    // Fetch Proposals
    mapping(uint => Proposal) public proposals;
    // Store Proposals count
    uint public proposalsCount;

    constructor(string memory _proposalHash) public {
        admin = msg.sender;
        voters[admin].weight = 1;
        // add proposal for proposalHash
        // proposals.add()
    }

    function addProposal (string memory _proposal) private {
        proposalsCount ++;
        proposals[proposalsCount] = Proposal(proposalsCount, _proposal, 0);
    }
}