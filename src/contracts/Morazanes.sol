// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Morazan is ERC20 {
    address payable private _feeWallet;
    uint256 private _feePercentage;

    event FeeTransferred(address indexed feeWallet, uint256 amount);

    constructor() ERC20("Morazan", "MZN") {
        // Esta wallet puede ser una wallet donde vayan los gobiernos del estado.
        // Por ahora es una wallet provisional.
        _feeWallet = payable(0x2E21ebbd5df6413E2300b51Fc4514093A3887CFD);
    }

    function faucet() public {
        _mint(msg.sender, 1500 ether);
    }

    function payWithISV(
        address recipient,
        uint256 amount
    ) public returns (bool) {
        // 12% impuesto sobre venta
        uint256 feeAmount = (amount * 12) / 100;

        super.transfer(recipient, amount);
        super.transfer(_feeWallet, feeAmount);

        return true;
    }
}
