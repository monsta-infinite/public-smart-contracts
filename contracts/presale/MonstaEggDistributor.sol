// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract MonstaEggDistributor is ERC721Holder {
    IERC20 eggContract;
    IERC721Enumerable coreContract;
    
    constructor(address _eggAddress, address _coreAddress) {
        eggContract = IERC20(_eggAddress);
        coreContract = IERC721Enumerable(_coreAddress);
    }
    
    function claim() external {
        eggContract.transferFrom(msg.sender, address(this), 1);
        uint256 monstaId = coreContract.tokenOfOwnerByIndex(address(this), 0);
        coreContract.transferFrom(address(this), msg.sender, monstaId);
    }
}