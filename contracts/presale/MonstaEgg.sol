// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract MonstaEgg is ERC20, Ownable, ERC20Pausable, ERC20Burnable {
    mapping(address => bool) public whitelist;

    constructor() ERC20("Inception Monsta Egg", "IMEGG") {
        _mint(msg.sender, 4088);
    }
    
    function decimals() public pure override returns (uint8) {
        return 0;
    }

    function renounceOwnership() public onlyOwner override {
        // Do nothing
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount) internal override(ERC20, ERC20Pausable) {
        require(from == address(0) || from == owner() || whitelist[to], "ERC20: invalid receiver");
        super._beforeTokenTransfer(from, to, amount);
    }
    
    function setWhitelist(address _address, bool _status) external onlyOwner {
        whitelist[_address] = _status;
    }
}