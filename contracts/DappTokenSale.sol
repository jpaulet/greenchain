pragma solidity ^0.5.1;

import "./DappToken.sol";

contract DappTokenSale {
    address payable admin;
    DappToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    // Events
    event Sell(address _buyer, uint256 _amount);

    /**
     * Constructor function
     *
     * Initializes contract with token price
     */
    constructor (DappToken _tokenContract, uint256 _tokenPrice) public {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;
    }

    // Safe Math Multiply funciton
    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    /**
     * Buy Tokens function
     *
     * Allows users to buy tokens
     */
    function buyTokens(uint256 _numberOfTokens) public payable {
        require(msg.value == multiply(_numberOfTokens, tokenPrice));
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);
        require(tokenContract.transfer(msg.sender, _numberOfTokens));

        tokensSold += _numberOfTokens;

        emit Sell(msg.sender, _numberOfTokens);
    }

    /**
     * End Sale function
     *
     * Allows the admin to finish the token sale and transfer all 
     * remaining tokens to admin address
     */
    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));

        // Transfer the balance to the admin
        admin.transfer(address(this).balance);
    }

    /**
     * Set Price function
     *
     * Allows admin to set a new token price
     */
    function setPrices(uint256 newtokenPrice) public {
        require(msg.sender == admin);
        tokenPrice = newtokenPrice;
    }
}