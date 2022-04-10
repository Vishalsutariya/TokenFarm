pragma solidity ^0.5.0;

import "./DaiToken.sol";
import "./DappToken.sol"; 

contract TokenFarm{
    string public name = "DApp Token Farm";
    DappToken public dappToken;
    DaiToken public daiToken;

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken, DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
    }

    // Stakes tokens (Investors Deposit)
    function stakeTokens(uint _amount) public {
        //code goes here for depost tokens

        //Transfer Mock Dai to this contract for staking
        daiToken.transferFrom(msg.sender, address(this), _amount);

        //Update staking balance here...
        stakingBalance[msg.sender] = stakingBalance[msg.sender] + _amount;

        //Add user to stakers array only if they haven't staked already
        if(!hasStaked[msg.sender]) stakers.push(msg.sender);

        //Update staking status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
    }


    // Unstakes token (Investors Withdraw)


    // Issuing Tokens (Investors Earn interest on deposits)
}