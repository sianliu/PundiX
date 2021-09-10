

// SPDX-License-Identifier: UNLICENSED 

pragma solidity ^0.7.3;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';            // transfer events specified here 
import '@openzeppelin/contracts/access/Ownable.sol';
// import './ERC1132.sol';                                          // lock struct, mapping specified here 

/**
* @dev Implementation of Pundi X Blockchain Developer (Preliminary Test)
*
* Future Improvements: 
* 1) Add Events 
* 2) Apply OpenZeppelin, Consensus, and/or Parity security checklists 
* 3) Write more robust test cases 
* 4) Run all external contracts locally
*/

abstract contract TokenJonLiu is ERC20, Ownable  {

    /**
    * @dev Error messages for require statements
    */
    string internal constant AMOUNT_ZERO = 'Amount cannot be 0';
    string internal constant ACCOUNT_BALANCE = 'ERC20: account balance should be larger than amount to burn';
    string internal constant ONLY_ADMIN = 'Only admin can mint';

    address public admin;
    // all private variables start with an underscore '_'
    mapping(address => uint256) private _balances;
    uint256 private _totalSupply; 
    // bool _unlockable; 
    string private _name = 'TokenJonLiu';
    string private _symbol = 'LWS'; 
    address private _owner;
    address private _previousOwner;
    uint private _lockTime; 
    
    // for lock function
    address public creator;
    // address public owner; 
    uint public unlockDate;
    uint public createdAt; 

    /**
    * @param name_ Token Name = TokenJonLiu
    * @param symbol_ TOKEN_TICKER = LWS 
    *
     */
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
        admin = msg.sender;
        // ERC20('Token Name', 'TOKEN_TICKER');
        // mints initial supply 10^6 tokens
        _mint(msg.sender, 1000000);
    }

    /**
        call this function to mint another 10^6 tokens
        @param to in this case msg.sender 
        @param amount 1,000,000  
     */
    function mint(address to, uint amount) external {
        require(msg.sender == admin, ONLY_ADMIN);
        _mint(to, amount); 
    }

    /**
    *  @dev Destroys `amount` tokens from `account`, reducing the
    *  total supply.
    *  @param account cannot be zero address and must have at least `amount` of tokens
    *  @param amount number of tokens to destroy - ie. 500,000 tokens.
    *
     */
    function _burn(address account, uint256 amount) override internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");
        // _beforeTokenTransfer(account, address(0), amount);
        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, ACCOUNT_BALANCE); 
        // unchecked {
        //     _balances[account] = accountBalance - amount;
        // }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        // _afterTokenTransfer(account, address(0), amount);

    }

    /**
     * @dev EIP-1132 implementation: Locks a specified amount of tokens against an address, for a specified reason and time
     * @param _reason The reason to lock tokens
     * @param _amount Number of tokens to be locked
     * @param _time Lock time in seconds
     */
    /**
    * @dev Locks the contract for owner for the amount of time specified 
    *
    * @param time amount of time to lock the contract for
    */
    function lock(uint time) public virtual onlyOwner {
        _previousOwner = _owner; 
        _owner = address(0);
        _lockTime = block.timestamp + time;
        // emit OwnershipTransferred(_owner, address(0)); 
    }


} // end TokenJonLiu contract 

