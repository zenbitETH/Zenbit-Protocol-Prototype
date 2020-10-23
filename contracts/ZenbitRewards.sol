pragma solidity ^0.6.2;
import "openzeppelin-solidity/contracts/access/AccessControl.sol";
import "openzeppelin-solidity/contracts/GSN/Context.sol";
import "openzeppelin-solidity/contracts/token/ERC1155/ERC1155.sol";
import "openzeppelin-solidity/contracts/token/ERC1155/ERC1155Holder.sol";
import "openzeppelin-solidity/contracts/token/ERC1155/ERC1155Burnable.sol";
import "openzeppelin-solidity/contracts/token/ERC1155/ERC1155Pausable.sol";

contract ZenbitRewards is Context, AccessControl, ERC1155Burnable, ERC1155Pausable, ERC1155Holder {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    uint256 public constant ZNBT = 1;
    uint256 public constant VAL1 = 2;
    uint256 public constant VAL2 = 3;
    uint256 public constant VAL3 = 4;
    uint256 public constant VAL4 = 5;
    string public name;
   
     constructor(string memory ZenbitRewards, string memory _name) public ERC1155 (ZenbitRewards) {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(MINTER_ROLE, _msgSender());
        _setupRole(PAUSER_ROLE, _msgSender());
        name = _name;
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
    ) internal virtual override(ERC1155, ERC1155Pausable) {
        super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
    }
}
