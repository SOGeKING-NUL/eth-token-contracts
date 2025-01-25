//SPDX-License-Identifer: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "src/Token.sol";


contract EmitTest is Test{
    Token public c;
    event Transfer(address indexed from, address indexed to, uint amount);

    function setUp() public{
        c= new Token();
    }

    function test_ExpectEmit() public{

        c.mintTo(address(this), 1000);
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), 0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24, 500);
        c.transfer(0x4Ff64D715C377b4e96d533e3dAE2C5c7B00E6D24, 500);

    }
}
