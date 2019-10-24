pragma solidity >=0.4.22 < 0.6.0;
contract Election{
    struct Voter {
        string name;
        uint256 vote_count;
        address voter_address;
    }
    struct Candidate {
        string name;
        uint256 vote_count;
        address candidate_address;
    }
    address owner;
    uint256 voters_count;
    uint256 candidates_count;
    mapping(uint256 => Candidate) candidates;

    mapping(uint256 => uint256) vote_for;
    mapping(uint256 => Voter) voters;

    constructor() public{
        owner = msg.sender;
    }
    modifier is_owner(){
        assert(msg.sender == owner);
        _;
    }
    function register_candidate(string memory _name, address _address) public is_owner returns(bool status){
        for (uint256 index = 0; index < candidates_count; index++) {
            if(compareStrings(candidates[index].name, _name)){
                return false;
            }
        }
        Candidate memory candidate;
        candidate.name = _name;
        candidate.candidate_address = _address;
        candidates[candidates_count] = candidate;
        candidates_count++;
        return true;
    }
    function vote_for_candidate(string memory _name, address _address, uint256 _vote_count, uint256 _vote_for) public returns(bool status){
        for (uint256 index = 0; index < voters_count; index++) {
            if(voters[index].voter_address == _address){
                return false;
            }
        }
        Voter memory voter;
        voter.name = _name;
        voter.vote_count = _vote_count;
        voter.voter_address = _address;
        voters[voters_count] = voter;
        candidates[_vote_for].vote_count = candidates[_vote_for].vote_count + _vote_count;
        vote_for[voters_count] = _vote_for;
        voters_count++;
        return true;
    }
    function get_id(string memory _name) public view returns(uint256 id) {
       for (uint256 index = 0; index < candidates_count; index++) {
           if(compareStrings(candidates[index].name, _name)){
               return index;
           }
       } 
       return 1000000;
    }
    function get_vote_count(uint256 _id) public view returns(uint256 vote_count) {
       return candidates[_id].vote_count;
    }
    function compareStrings (string memory a, string memory b) internal pure returns (bool) {
        return (keccak256(abi.encodePacked((a))) == keccak256(abi.encodePacked((b))) );
    }
}