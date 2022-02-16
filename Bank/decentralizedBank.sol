// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

contract Bank {

    event bankDeposit(address indexed _depositer, uint256 _amount);
    event bankWithdrawal(address indexed _depositer, uint256 _amount);

    address public bank;
    mapping(address => uint256) private deposits;

    constructor() {
        bank = msg.sender;
    }

    function deposit() payable public {
        deposits[msg.sender] += msg.value;
        emit bankDeposit(msg.sender, msg.value);
    }

    function withdrawal(uint256 amount) public {
        require(deposits[msg.sender] >= amount, "You are not the bank owner");
        deposits[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
        emit bankWithdrawal(msg.sender, amount);
    }

    function balanceOf(address depositor) public view returns(uint256) {
        return deposits[depositor];
    }
}