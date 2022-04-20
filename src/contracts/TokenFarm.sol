// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./DaiToken.sol";
import "./DappToken.sol";

contract TokenFarm {
    string public name = "DApp Token Farm";
    address public owner;
    DappToken public dappToken;
    DaiToken public daiToken;
    

    address[] public stakers;
    mapping(address => uint256) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
        owner = msg.sender;
    }

    // Stakes tokens (Investors Deposit)
    function stakeTokens(uint256 _amount) public {
        //code goes here for depost tokens

        //Require amount greater than 0
        require(_amount > 0, "amount cannot be 0");

        //Transfer Mock Dai to this contract for staking
        daiToken.transferFrom(msg.sender, address(this), _amount);

        //Update staking balance here...
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        //Add user to stakers array only if they haven't staked already
        if (!hasStaked[msg.sender]) stakers.push(msg.sender);

        //Update staking status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }

    // Issuing Tokens (Investors Earn interest on deposits)
    function issueToken() public {
        //Only owner can call this function
        require(msg.sender == owner, "Caller must be owner");

        //Issue tokens to all stakers
        for (uint256 i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint256 balance = stakingBalance[recipient];
            if (balance > 0) dappToken.transfer(recipient, balance);
        }
    }

    // Unstakes token (Investors Withdraw)
    function unstakeTokens() public{
        //Fetch staking balance
        uint balance = stakingBalance[msg.sender];

        //Require amount greater than 0
        require(balance > 0, "staking balance  cannot be 0");

        //Transfer Mock Dai tokens to this contract for staking
        daiToken.transfer(msg.sender, balance);

        //Reset staking balance
        stakingBalance[msg.sender] = 0;

        //Update staking status
        isStaking[msg.sender] = false;
    }
}
