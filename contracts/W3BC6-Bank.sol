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

     //Declare an Event

event makepayment(address indexed _from, address indexed _id, uint _value);


       constructor () {
         owner = msg.sender;
     }

    mapping(address => uint) user_balance;
    uint private bank_balance; 

    fallback() external payable {
        revert("invalid action");
    }
    receive() external payable {
        revert("invalid action");
    }

    function deposit() payable public{
        require(msg.value > 0, "Amount to be deposited is too small");
        user_balance[msg.sender] += msg.value;
        bank_balance += msg.value;
        
        emit makepayment(msg.sender, address(this), msg.value);
    }

    function withdraw(uint _amount)external{
        require (user_balance[msg.sender] >= _amount, 'Insufficent funds');
        user_balance[msg.sender] -= _amount;
        bank_balance -= _amount;
        (bool sent, bytes memory data) = msg.sender.call{value: _amount}('');
        require(sent == true, "withdrawal failed");
    }

    function get_user_balance() public view returns(uint) {

    return user_balance[msg.sender];
    
    }
    function transfer (uint _amount, address _to) external returns (bytes memory){
        require (user_balance[msg.sender] >= _amount, 'Insufficent funds');
        user_balance[msg.sender] -= _amount;
        bank_balance -= _amount;
        (bool sent, bytes memory data) = _to.call{value: _amount}('');
        require(sent, "transacation failed");

        emit makepayment(msg.sender, _to, _amount);

        return data; 
    }
}