pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Full.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721Burnable.sol";

// import "@openzeppelin/contracts/token/ERC721/ERC721Metadata.sol";
// import "@openzeppelin/contracts/token/ERC721/ERC721Enumerable.sol";

// inherit from the openzeppelin library
contract MyContract is ERC721Full {
    constructor() public ERC721Full("My super token", "MST") {}
}
