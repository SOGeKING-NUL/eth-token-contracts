// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Token{
    string public name= "SOGeCoin";
    uint public supply = 0;
    address public owner;
    mapping(address => uint) public balances;
    mapping(address account => mapping(address sender=> uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint amount);


    constructor(){
        owner= msg.sender;
    }

    function mintTo(address to, uint amount) public{
        require(msg.sender == owner, "mint authority is not the contract deployer");
        balances[to] += amount;
        supply +=amount;
    }

    function transfer(address to, uint amount) public{
        require(balances[msg.sender] >= amount, "Not enough balance to transfer");
        balances[to] += amount;
        balances[msg.sender] -=amount;
        emit Transfer(msg.sender, to, amount);
    }

    function burn(uint amount) public{
        require(balances[msg.sender] >= amount, "amount to burn is greater than balance");
        balances[msg.sender] -= amount;
        supply -=amount;
    }

    function allow(address to, uint amount) public{
    require(balances[msg.sender] >= amount, "allowance is greater than balance");
    allowance[msg.sender][to]= amount;    
    }

    function transferFrom(address from, address to, uint amount) public{
        uint balance= balances[from];
        require(balance >=amount);
        uint currentAllowance= allowance[from][to];
        require(currentAllowance >= amount);
        balances[from] -= amount;
        balances[to] += amount;
        allowance[from][to] -= amount;
    }
}