// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Morazan is ERC20 {
    address payable private _feeWallet;
    uint256 private _feePercentage;

    event FeeTransferred(address indexed feeWallet, uint256 amount);

    constructor(address payable feeWallet) ERC20("Morazan", "MZN") {
        _mint(msg.sender, 21000000000000000000000);
        _feeWallet = feeWallet;
        _feePercentage = 15;
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        uint256 feeAmount = (amount * _feePercentage) / 100;
        //uint256 amountAfterFee = amount - feeAmount;
        
        super.transfer(recipient, amount);
        super.transfer(_feeWallet, feeAmount);
        
        return true;
    }
}
