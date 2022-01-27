// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract Dispenser {

    address public owner;
    mapping(address => uint) public sodaBalance;

    constructor() {
        owner = msg.sender;
        sodaBalance[address(this)] = 100;
    }

    function restock(uint _amount) public {
        require(msg.sender == owner, "Only the owner can restock this machine");
        sodaBalance[address(this)] += _amount;
    }

    function purchase(uint _amount) public payable {
        require(msg.value >= _amount * 2 ether, "You must pay at least 2 ETH for a soda");
        require(sodaBalance[address(this)] >= _amount, "Not enough sodas to purchase, please wait until they are restocked");
        sodaBalance[address(this)] -= _amount;
        sodaBalance[msg.sender] += _amount;

    }

}