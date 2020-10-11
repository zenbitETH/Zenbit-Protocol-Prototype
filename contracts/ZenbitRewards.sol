pragma solidity ^0.6.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/AccessControl.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/GSN/Context.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155Holder.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155Pausable.sol";

contract ZenbitRewards is Context, AccessControl, ERC1155Burnable, ERC1155Pausable, ERC1155Holder {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    uint256 public constant ZNBT = 1;
    uint256 public constant VAL1 = 2;
    uint256 public constant VAL2 = 3;
    uint256 public constant VAL3 = 4;
    uint256 public constant VAL4 = 5;
   
     constructor(string memory ZenbitRewards) public ERC1155 (ZenbitRewards) {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());

        _setupRole(MINTER_ROLE, _msgSender());
        _setupRole(PAUSER_ROLE, _msgSender());
        _mint(msg.sender, 1, 1000000*10**18, "zNTB");
        _mint(msg.sender, 2, 1*10**18, "CS1");
        _mint(msg.sender, 3, 1*10**18, "CS2");
        _mint(msg.sender, 4, 1*10**18, "DS1");
        _mint(msg.sender, 5, 1*10**18, "DS2");
     }

   
    function mint(address to, uint256 id, uint256 amount, bytes memory data) public virtual {
        require(hasRole(MINTER_ROLE, _msgSender()), "ZenbitRewards: must have minter role to mint");

        _mint(to, id, amount, data);
    }

    
    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public virtual {
        require(hasRole(MINTER_ROLE, _msgSender()), "ZenbitRewards: must have minter role to mint");

        _mintBatch(to, ids, amounts, data);
    }


    function pause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "ZenbitRewards: must have pauser role to pause");
        _pause();
    }


    function unpause() public virtual {
        require(hasRole(PAUSER_ROLE, _msgSender()), "ZenbitRewards: must have pauser role to unpause");
        _unpause();
    }

    function _beforeTokenTransfer(
        address operator,
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    )
        internal virtual override(ERC1155, ERC1155Pausable)
    {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
