// SPDX-License-Identifier: MIT

pragma solidity ^0.7.3;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import "./IERC20.sol";          // transfer events specified here 

contract TokenJonLiu is ERC20 {
    address public admin;
    // all private variables start with an underscore '_'
    mapping(address => uint256) private _balances;
    uint256 private _totalSupply; 

    constructor() {
        admin = msg.sender;
        ERC20('Token Name', 'TOKEN_TICKER');
        // mints initial supply 10^6 tokens
        _mint(msg.sender, 1000000);
    }

    /**
        call this function to mint another 10^6 tokens
        @param to in this case msg.sender 
        @param amount 1,000,000  
     */
    function mint(address to, uint amount) external {
        require(msg.sender == admin, "Only admin can mint");
        _mint(to, amount); 
    }

    /**
    *  @dev Destroys `amount` tokens from `account`, reducing the
    *  total supply.
    *  @param account cannot be zero address and must have at least `amount` of tokens
    *  @param amount number of tokens to destroy - ie. 500,000 tokens.
    *
     */
    function burn(address account, uint256 amount) {
        require(account != address(0), "ERC20: burn from the zero address");
        // _beforeTokenTransfer(account, address(0), amount);
        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: account balance should be larger than amount to burn"); 
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        // _afterTokenTransfer(account, address(0), amount);

    }

    /**
    * @dev 1. approve > 2. deposit 3. > transferFrom
    *
    *
     */
    function lock() {

    }
}

