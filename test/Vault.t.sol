// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {MyVault} from "../src/ERC4626.sol";
import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

// Mock Token for testing
contract MockToken is ERC20 {
    constructor() ERC20("Mock Token", "MTK") {
        _mint(msg.sender, 1000000 * 10 ** 18);
    }
}

contract VaultTest is Test {
    MyVault public vault;
    MockToken public token;

    function setUp() public {
        token = new MockToken();
        vault = new MyVault(token);
    }

    function testDeposit() public {
        // 1. Approve vault to spend tokens
        token.approve(address(vault), 100 * 10 ** 18);

        // 2. Deposit 100 tokens
        uint256 shares = vault.deposit(100 * 10 ** 18, address(this));

        // 3. Check shares received (1:1 ratio initially)
        assertEq(shares, 100 * 10 ** 18);
        assertEq(vault.balanceOf(address(this)), 100 * 10 ** 18);
        assertEq(token.balanceOf(address(vault)), 100 * 10 ** 18);
    }

    function testWithdraw() public {
        token.approve(address(vault), 100 * 10 ** 18);
        vault.deposit(100 * 10 ** 18, address(this));

        // Withdraw 50 tokens
        vault.withdraw(50 * 10 ** 18, address(this), address(this));

        assertEq(vault.balanceOf(address(this)), 50 * 10 ** 18);
        assertEq(
            token.balanceOf(address(this)),
            1000000 * 10 ** 18 - 50 * 10 ** 18
        );
    }
}
