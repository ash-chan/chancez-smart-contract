pragma solidity ^0.4.18;

    /**
    * Example script for the Ethereum development walkthrough
    */

contract Investment {
    /**
    * Our wrestlers
    */
    address public investor;
    address public student;
    address public chancez;

    bool public investorSent;
    bool public studentReceived;

    uint private investorDeposit;
    uint private studentDeposit;

    bool public contractFulfilled;

    mapping(address => uint256) balance;


    event StartInvestmentEvent(address investor, address student);

    /**
    * The contract constructor
    */
    constructor() public {
	    investor = msg.sender;
    }


    function registerAsReceiver() public {
        require(student == address(0));

        student = msg.sender;

    }

    function registerAsChancez() public {
        require(chancez == address(0));

        chancez = msg.sender;
        emit StartInvestmentEvent(investor, student);
    }

    function pay(address _chancez) public payable returns(bool success) {
        // uint paid = msg.value
        uint paid = msg.value;
        _chancez.transfer(paid);
        balance[_chancez] += paid;
        return true;
    }

    function claim(address _student) public payable returns(bool success) {
        uint amount = msg.value;
        _student.transfer(amount - txfee);
        balance[_student] += (amount - txfee);
        return true;
    }


    function () public payable {
        revert();
    }
}