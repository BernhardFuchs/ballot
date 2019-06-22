pragma solidity >=0.4.22 <0.6.0;
contract Ballot {
    struct Voter {
        uint weight;
        bool voted;
        uint8 vote;
        address delegate;
    }
    struct Proposal {
        bytes32 settingHash;
        uint voteCount;
    }

    address chairperson;
    Proposal currentProposal;
    mapping(address => Voter) voters;
    Proposal[2] proposals;
    
    constructor (bytes32 _settingHash) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        currentProposal.settingHash = _settingHash;
        proposals[0].settingHash = _settingHash;
    }
    
    function addProposal(bytes32 _settingHash) public {
        if (msg.sender != chairperson) return;
        proposals[1].settingHash = _settingHash;
    }

    /// Give $(toVoter) the right to vote on this ballot.
    /// May only be called by $(chairperson).
    // function giveRightToVote(address toVoter) public {
    //     if (msg.sender != chairperson || voters[toVoter].voted) return;
    //     voters[toVoter].weight = 1;
    // }

    /// Give a single vote to proposal $(toProposal).
    // function vote(uint8 toProposal) public {
    //     Voter storage sender = voters[msg.sender];
    //     if (sender.voted || toProposal >= proposals.length) return;
    //     sender.voted = true;
    //     sender.vote = toProposal;
    //     proposals[toProposal].voteCount += sender.weight;
    // }

    // function winningProposal() public view returns (uint8 _winningProposal) {
    //     uint256 winningVoteCount = 0;
    //     for (uint8 prop = 0; prop < proposals.length; prop++)
    //         if (proposals[prop].voteCount > winningVoteCount) {
    //             winningVoteCount = proposals[prop].voteCount;
    //             _winningProposal = prop;
    //         }
    // }
}
