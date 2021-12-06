pragma solidity ^0.8.0;

contract MyNFTToken {
    // initialize the variables
    string public name = "Lolu's NFT";
    string public symbol = "LNFT";

    // key-value pair (uint256(tokenId) - address(owner's address))
    mapping(uint256 => address) public owners;

    // key-value pair (address(owner's address) - uint256(balance))
    mapping(address => uint256) public balance;
    mapping(uint256 => address) public approvals;

    // events to be emitted
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 indexed _tokenId
    );
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );

    // initializing the contract with the declared name and symbol
    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    }

    // returns the token name
    function nftName() public view returns (string memory) {
        return name;
    }

    // returns the token symbol
    function nftSymbol() public view returns (string memory) {
        return symbol;
    }

    // returns the balance of the owner
    function balanceOf(address owner) public view returns (uint256) {
        // checking to ensure that the address of the owner is not 0x0...
        require(
            owner != address(0),
            "ERC721: balance query for the zero address"
        );
        // returning the number of NFTs owned by the owner
        return balance[owner];
    }

    // returns the owner of the token
    function ownerOf(uint256 _tokenId) public view returns (address) {
        // passes the token id of the NFT, to select the owner with set token identifier
        address owner = owners[_tokenId];
        // checking to ensure that the address of the owner is not 0x0...
        require(
            owner != address(0),
            "ERC721: owner query for nonexistent token"
        );
        // returning the address of the owner of the NFT
        return owner;
    }

    // from: the owner of the NFT; to: the new owner of the NFT, tokenId: the NFT to transfer
    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external payable {
        require(
            ownerOf(_tokenId) == _from,
            "ERC721: transfer of token that is not own"
        );
        require(_to != address(0), "ERC721: transfer to the zero address");

        // updating the new balance of the NFT owner
        balance[_from] -= 1;
        // updating the new balance of the NFT receiver (it's new owner)
        balance[_to] += 1;
        // adding new NFT owner to the owners map
        owners[_tokenId] = _to;

        // calling the transfer event
        emit Transfer(_from, _to, _tokenId);
    }

    function approve(address _approved, uint256 _tokenId) external payable {
        // making the caller of this function is the owner of the NFT
        require(ownerOf(_tokenId) == msg.sender);
        // getting the owner
        address owner = ownerOf(_tokenId);
        // making sure it isn't being approved for the owner of the NFT
        require(_approved != owner, "ERC721: approval to current owner");

        // calling the approve event
        emit Approval(ownerOf(_tokenId), _approved, _tokenId);
    }

    function getApproved(uint256 _tokenId) external view returns (address) {
        require(
            owners[_tokenId] != address(0),
            "ERC721: approved query for nonexistent token"
        );

        return approvals[_tokenId];
    }
}
