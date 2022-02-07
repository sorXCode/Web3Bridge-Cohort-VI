// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.6;


contract Bank {
    /* Features: 
        - Deposit => user can pay into their account
        - withdraw => user can withdraw from their account
        - get_users_balance => user can view their account balance
        - get_bank_balance => the contract owner can view the total amount in the bank 
        - transfer => user can transfer funds to another account
        ------------------------------------------------------------------------------------------
        improvements:
        - use fallback/receive method
        - separate contracts: one for bank, and the other for user
        - apply DRY(Don't Repeat Yourself) to withdraw and transfer_to_address functions
        - check against 0x0000000000000000000000000000000000000000 address for transactions
    */
     address immutable private owner;
       constructor () {
         owner = msg.sender;
     }

    mapping(address => uint) user_balance;
    uint private bank_balance; 

    function deposit() payable public{
        require(msg.value > 0, "Amount to be deposited is too small");
        user_balance[msg.sender] += msg.value;
        bank_balance += msg.value;
    }
    function transfer (uint _amount, address _to) external returns (bytes memory){
        require (user_balance[msg.sender] >= _amount, 'Insufficent funds');
        user_balance[msg.sender] -= _amount;
        bank_balance -= _amount;
        (bool sent, bytes memory data) = _to.call{value: _amount}('');
        require(sent, "transacation failed");
        return data;
    }
}