// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract RealEstateAgreement {

    address private owner;
    uint256 public price;
    bool public sellPaysClosingFees;

    constructor(uint256 _price) {
        owner = msg.sender;
        price = _price;
        sellPaysClosingFees = false;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Unauthorized. Only owner can modify contract.");
        _;
    }

    function setPrice(uint256 _price) public onlyOwner {
        price = _price;
    }

    function setClosingFeeAgreement(bool _ownerPays) public onlyOwner {
        sellPaysClosingFees = _ownerPays;
    }
}