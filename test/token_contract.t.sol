//SPDX-Liscense-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

import "src/Token.sol";

contract TestToken is Test{ 
    Token c;

    function setUp() public{
        c= new Token();
    }

    function testMint() public{
        c.mintTo(address(this), 100);
        assertEq(c.balances(address(this)),100, "ok");
        assertEq(c.balances(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24), 0, "ok");

        c.mintTo(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24, 150);
        assertEq(c.balances(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24),150, "ok");
    }

    function testTransfer() public{
        c.mintTo(address(this), 2000);
        c.transfer(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24, 500);
        assertEq(c.balances(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24),500, "ok");

        vm.prank(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24);
        c.transfer(address(this), 200);
        assertEq(c.balances(address(this)), 1700);
    }

    function testAllowance() public{
        c.mintTo(address(this), 10);
        assertEq(c.balances(address(this)), 10);
        assertEq(c.balances(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24), 0);

        c.allow(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24, 2);
        assertEq(c.allowance(address(this), 0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24), 2);
        assertEq(c.allowance(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24, address(this)), 0);
        
        vm.prank(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24);
        c.transferFrom(address(this), 0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24, 1);
        assertEq(c.balances(address(this)), 9);
    }
}