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

    address serverAdmin;
    bytes32 currentSettingHash;
    bytes32 serverNameHash;
    mapping(address => Voter) voters;
    Proposal[2] proposals;

    constructor (bytes32 _serverNameHash, bytes32 _initSettingHash) public {
        serverAdmin = msg.sender;
        voters[serverAdmin].weight = 1;
        serverNameHash = _serverNameHash;
        currentSettingHash = _initSettingHash;
    }

    function addProposal(bytes32 _settingHash) public {
        isServerAdmin();
        proposals[0].settingHash = currentSettingHash;
        proposals[1].settingHash = _settingHash;
    }

    /// Give $(toVoter) the right to vote on this ballot.
    /// May only be called by $(serverAdmin).
    function giveRightToVote(address toVoter) public {
        isServerAdmin();
        require(!voters[toVoter].voted, "The voter already voted.");
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

    /// Returns 0 if server changes are not accepted
    /// Returns 1 if server changes are accepted
    /// If server changes are accepted the currentSettingHash
    /// is replaced with the changes
    function closeBallot() public returns (uint8 _winningProposal) {
        isServerAdmin();
        uint256 winningVoteCount = 0;
        for (uint8 prop = 0; prop < proposals.length; prop++) {
            if (proposals[prop].voteCount > winningVoteCount) {
                winningVoteCount = proposals[prop].voteCount;
                _winningProposal = prop;
            }
        }
        if (_winningProposal == 1) currentSettingHash = proposals[1].settingHash;
    }

    function isServerAdmin() private view returns (bool) {
        require(msg.sender == serverAdmin, "Invalid permissions");
    }

}
