// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "base64-sol/base64.sol";

contract RLNFT is ERC721 {
    uint256 public s_tokenCounter;
    string constant IMAGEURI =
        "ipfs/bafkreibwwkxbby6jdr3wzagd45whgddhxcl3hem326tmtrw76234eu6c5y?filename=WIN_20230227_10_20_04_Pro%20(2).jpg";

    //mapping of tokenId to token metadata
    mapping(uint256 => string) IdtoURI;

    //mapping of addresses to Ids
    mapping(address => uint256[]) addressToIds;

    address internal immutable caller;

    constructor(address _caller) ERC721("RidLearnNFT", "RLN") {
        caller = _caller;
    }

    function MintNft(
        address newInstructor,
        string memory _name,
        string memory profession,
        string memory briefIntro,
        string[] memory links,
        string memory imageLink,
        address receiver
    ) public returns (uint256) {
        require(msg.sender == caller, "cannot be called");
        uint256 currentId = s_tokenCounter;
        s_tokenCounter = s_tokenCounter + 1;
        addressToIds[receiver].push(currentId);

        _safeMint(newInstructor, currentId);
        URI(_name, profession, briefIntro, links, imageLink, currentId);
        return currentId;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return string(Base64.decode(IdtoURI[tokenId]));
    }

    function URI(
        string memory _name,
        string memory profession,
        string memory briefIntro,
        string[] memory links,
        string memory imageLink,
        uint256 tokenId
    ) public {
        string memory Uri = string(
            abi.encodePacked(
                _baseURI(),
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"',
                            name(),
                            '", "description":"An NFT that represent that you are an instructor on the Ridlearn platform", ',
                            '"Owner":[{"name": "',
                            _name,
                            '", "profession":"',
                            profession,
                            '", "links":[{"linkedIn":"',
                            links[0],
                            '", "faceBook":"',
                            links[1],
                            '"}], "profilePicture":"',
                            imageLink,
                            '", "briefIntro":"',
                            briefIntro,
                            '"}], "imageURI":"',
                            IMAGEURI,
                            '"}'
                        )
                    )
                )
            )
        );
        IdtoURI[tokenId] = Uri;
    }

    function getTokensOwned(address _address) public view returns (uint256[] memory) {
        return addressToIds[_address];
    }
}
