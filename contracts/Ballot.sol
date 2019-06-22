pragma solidity >=0.4.22 <0.6.0;
contract Ballot {

    struct Voter {
        uint weight;
        bool voted;
        bool accepted;
    }
    struct Proposal {
        bytes32 settingHash;
        uint voteCount;
    }

    address chairperson;
    bytes32 currentSettingHash;
    mapping(address => Voter) voters;
    Proposal[2] proposals;
    
    constructor (bytes32 _settingHash) public {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;
        currentSettingHash = _settingHash;
    }
    
    function addProposal(bytes32 _settingHash) public {
        if (msg.sender != chairperson) return;
        proposals[0].settingHash = currentSettingHash;
        proposals[1].settingHash = _settingHash;
    }
    
    /// Give $(toVoter) the right to vote on this ballot.
    /// May only be called by $(chairperson).
    function giveRightToVote(address toVoter) public {
        if (msg.sender != chairperson || voters[toVoter].voted) return;
        voters[toVoter].weight = 1;
    }
    
    /// Accept new server setting $(accepted).
    function acceptSettingChange(bool accepted) public {
        Voter storage sender = voters[msg.sender];
        if (sender.voted) return;
        sender.voted = true;
        sender.accepted = accepted;
        if(accepted) proposals[1].voteCount += sender.weight;
        else proposals[0].voteCount += sender.weight;
    }
    
    /// Returns 255 as Error Code if not the contract owner
    /// Returns 0 if server changes are not accepted
    /// Returns 1 if server changes are accepted
    function closeBallot() public returns (uint8 _winningProposal) {
        if (msg.sender != chairperson) return 255;
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++) {
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
        }
        if (_winningProposal == 1) currentSettingHash = proposals[1].settingHash;
    }

}
