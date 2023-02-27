// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Uncomment this line to use console.log
import "hardhat/console.sol";
import "./RLNFT.sol";

contract Profiler {
    uint256 internal s_instructorId;

    event newInstructor(
        string name,
        string profession,
        string briefIntro,
        string[] links,
        string imageLink,
        uint256 instructorId
    );

    event instructionEdited(uint256 instructorId);
    event instructorDeleted(uint256 instructorId);
    event new_User(address user, string name, string email, string imageLink);
    event user_Edited(address user);
    event user_Deleted(address user);

    function add_Instructor(
        string memory name,
        string memory profession,
        string memory briefIntro,
        string[] memory links,
        string memory imageLink,
        RLNFT _RLNFT
    ) public {
        _RLNFT.MintNft(msg.sender, name, profession, briefIntro, links, imageLink, msg.sender);
        emit newInstructor(name, profession, briefIntro, links, imageLink, s_instructorId);
    }

    function edit_InstructorProfile(uint256 instructorId) public {
        emit instructionEdited(instructorId);
    }

    function delete_InstructorProfile(uint256 instructorId) public {
        emit instructorDeleted(instructorId);
    }

    function add_User(string memory name, string memory email, string memory imageLink) public {
        emit new_User(msg.sender, name, email, imageLink);
    }

    function edit_UserProfile(address user_account) public {
        emit user_Edited(user_account);
    }

    function delete_UserProfile(address user_account) public {
        emit user_Deleted(user_account);
    }

    function transferETH(address _address) public payable {
        (bool success, ) = payable(_address).call{value: msg.value}("");
        require(success, "failed");
    }
}
