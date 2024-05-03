// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Voting {
    struct ParticipantDetails {
        address Participant;
        uint Count;
    }
    ParticipantDetails[] private VoteData;
    address private ElectionComissionMember;
    address[] private Nominators;
    address private Winner;

    constructor () {
        ElectionComissionMember = msg.sender;
    }

    function participate() public payable {
        require(msg.sender != ElectionComissionMember, "You are the election comission member");
        require(msg.value >= 1 ether, "You should pay minimum 1 ether to participate");
        Nominators.push(msg.sender);
        VoteData.push(ParticipantDetails(msg.sender, 0));
    }

    function Vote (uint _Id) public {
        VoteData[_Id].Count = VoteData[_Id].Count + 1;
    }

    function FindWinner () public view returns (address) {
        address _Id;
        uint _MaxVote = 0;

        for (uint i = 0;i < VoteData.length;i++) {
            if (VoteData[i].Count > _MaxVote) {
                _MaxVote = VoteData[i].Count;
                _Id = VoteData[i].Participant;
            }
        }

        return _Id;
    }
}

// 0x7aB7ABbA90E2aD1a8da9F8D17E1cB1e6bC55Aa40