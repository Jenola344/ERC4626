// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {
    ERC4626
} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC4626.sol";
import {IERC20} from "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

/**
 * @title MyVault
 * @dev A simple ERC4626 Vault using OpenZeppelin's implementation.
 *      This vault holds the underlying asset and issues "vTKN" shares.
 */
contract MyVault is ERC4626 {
    constructor(IERC20 asset) ERC4626(asset) ERC20("My Vault Co", "vCO") {}

    // That's it! The standard requires just the constructor to set the asset.
    //
    // However, a real vault usually overrides _deposit/_withdraw or totalAssets
    // to actually invest the funds into a strategy.
    //
    // For example, to lend on Aave:
    // function _deposit(address caller, address receiver, uint256 assets, uint256 shares) internal override {
    //     super._deposit(caller, receiver, assets, shares);
    //     // Lend `assets` to Aave
    // }
}
