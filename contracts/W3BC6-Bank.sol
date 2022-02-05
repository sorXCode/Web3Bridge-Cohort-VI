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

    function deposit() public payable {
        // logic added
    }
}