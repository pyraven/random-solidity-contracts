//SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

contract MyEvents {

    event Logger(address buyer, uint amount);
    event IndexedLogger(address indexed buyer, uint amount);

    function pseudoBuyFictionalNFT() public payable {
        require(msg.value >= 2 ether, "Sorry that's not enough for this affordable NFT");
        emit Logger(msg.sender, msg.value);
        emit IndexedLogger(msg.sender, msg.value);
    }

    function questionSelf() public pure returns(string memory) {
        return "Message from future self, don't buy this pseudo NFT. It will be a huge mistake.";
    }
}