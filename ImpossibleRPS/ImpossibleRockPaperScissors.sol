//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract ImpossibleRockPaperScissors {
    
    mapping(address => bool) public loserBlackList;
    address public owner;
    
    constructor() payable {
        owner = msg.sender;
    }
    
    function _toLower(string memory str) internal pure returns (string memory) {
        bytes memory bStr = bytes(str);
        bytes memory bLower = new bytes(bStr.length);
        for (uint i = 0; i < bStr.length; i++) {
            if ((uint8(bStr[i]) >= 65) && (uint8(bStr[i]) <= 90)) {
                bLower[i] = bytes1(uint8(bStr[i]) + 32);
            } else {
                bLower[i] = bStr[i];
            }
        }
        return string(bLower);
    }
    
    function checkJackpot() public view returns(uint) {
        return address(this).balance / 10**18;
    }
    
    function ownerBalance() public view returns(uint) {
        return owner.balance / 10**18;
    }
    
    function getCurrentPlayer() public view returns(address) {
        return msg.sender;
    }
    
    function computerChoice(string memory _choice) internal pure returns(string memory) {
        _choice = _toLower(_choice);
        if (keccak256(abi.encodePacked((_choice))) == keccak256(abi.encodePacked(('rock')))) {
            return "sorry, had paper this whole time.";
        } else if (keccak256(abi.encodePacked((_choice))) == keccak256(abi.encodePacked(('paper')))) {
            return "i got scissors, what did you have...oh. sorry";
        } else if (keccak256(abi.encodePacked((_choice))) == keccak256(abi.encodePacked(('scissors')))) {
            return "not sure why you went with that when i had rock since the beginning, sorry bud";
        } else {
            return "you did not select rock, paper or scissors. us computers dont have time for such games, blocked";
        }
    }
    
    function play(string memory _choice) public payable returns(string memory) {
        require(msg.value >= 2 ether, 'Bet too low.');
        require(!loserBlackList[msg.sender], 'user has already played');
        if (address(this).balance >= 10 ether) {
            payable(owner).transfer((address(this).balance - 1 ether));
        }
        if (msg.sender != owner) {
            loserBlackList[msg.sender] = true;
        }
        return computerChoice(_choice);
    }
}