/*
Joint Savings Account
---------------------

Using Solidity to automate the creation of joint savings accounts by creating a solidity smart contract,
which accepts two user addresses that are then able to control a joint savings account. 
The smart contract will use ether management functions to implement various requirements from the "financial institution" 
to provide the features of the joint savings account.
*/

pragma solidity ^0.5.0;
// New smart contract named `JointSavings`
contract JointSavings {

    // Variables for the new smart contract:
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;


    //Creation of a new function, **withdraw** that will accept two arguments.

    function withdraw(uint amount, address payable recipient) public {
        /*Define a `require` statement that checks if the `recipient` is equal to either `accountOne` or `accountTwo`. 
        The `requiere` statement returns the text `"You don't own this account!"` if it does not.*/
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        /*Define a `require` statement that checks if the `balance` is sufficient to accomplish the withdraw operation.
        If there are insufficient funds, the text `Insufficient funds!` is returned.*/
        require(address(this).balance >= amount, "Insufficient funds!");
        /*Add and `if` statement to check if the `lastToWithdraw` is not equal to (`!=`) to `recipient` If `lastToWithdraw` is not equal,
        then set it to the current value of `recipient`.*/
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }
        // Call the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.
        recipient.transfer(amount);
        // Set  `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;
        /* Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance'
        to reflect the new balance of the contract.*/
        contractBalance = address(this).balance;
    }

    // Create `public payable` function named `deposit`.
    function deposit() public payable {
        //Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance`.
        contractBalance = address(this).balance;
    }

    //Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
    function setAccounts(address payable account1, address payable account2) public{

        // Setting the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
        accountOne = account1;
        accountTwo = account2;

    }

    //Adding **default fallback function** so that the smart contract can store Ether sent from outside the deposit function.
    function() external payable {}
}