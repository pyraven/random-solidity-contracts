// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

interface IERC721 {
    function transferFrom(
        address from,
        address to,
        uint nftId
    ) external;
}

contract EnglishAuction {

    event Start();
    event Bid(address indexed sender, uint amount);
    event Withdraw(address indexed bidder, uint amount);
    event End(address highestBidder, uint highestBid);

    IERC721 public immutable nft;
    uint public immutable nftId;

    address payable public immutable seller;

    bool public started;
    bool public ended;
    uint public endedAt;

    address public highestBidder;
    uint public highestBid;
    mapping(address => uint) public bids;

    constructor(
        address _nft,
        uint _nftId,
        uint _startingBid
    ) {
        nft = IERC721(_nft);
        nftId = _nftId;
        seller = payable(msg.sender);
        highestBid = _startingBid;
    }

    function start() external {
        require(msg.sender == seller, "Only the seller can start the auction.");
        require(!started, "started");
        
        started = true;
        endedAt = uint32(block.timestamp + 7 days);
        nft.transferFrom(seller, address(this), nftId);

        emit Start();
    }

    function bid() external payable {
        require(started, "not started");
        require(block.timestamp < endedAt, "auction passed");
        require(msg.value > highestBid, "not higher than previous bid");

        if (highestBidder != address(0)) {
            bids[highestBidder] += highestBid;
        }
        highestBid = msg.value;
        highestBidder = msg.sender;

        emit Bid(msg.sender, msg.value);
    }
    
    function withdraw() external {
        uint bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);

        emit Withdraw(msg.sender, bal); 
     }

    function end() external {
        require(started, "not started");
        require(!ended, "ended");
        require(block.timestamp > endedAt, "not ended");
        
        ended = true;
        if (highestBidder != address(0)) {
            nft.transferFrom(address(this), highestBidder, nftId);
            seller.transfer(highestBid);
        } else {
            nft.transferFrom(address(this), seller, nftId);
        }
        emit End(msg.sender, highestBid);
    }
}