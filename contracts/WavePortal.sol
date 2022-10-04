// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;
    // Use this to help generate a random number
    uint256 private seed;

    // A little magic, Google what events are in Solidity!
    event NewWave(address indexed from, uint256 timestamp, string message);

    //I created a struct here named Wave.
    //A struct is basically a custom datatype where we can customize what we want to hold inside it.

    struct Wave {
        address waver; // The address of the user who waved
        string message; // The message the user sent
        uint256 timestamp; // The timestamp when the user waved
    }


    // Declare a variable waves that lets me store an array of structs.
    // This is what lets me hold all the waves anyone ever sends to me!

    Wave[] waves;

    // This is an address => uint mapping, meaning I can associate an address with a number!
    // In this case, I'll be storing the address with the last time the user waved at us.
    mapping(address => uint256) public lastWavedAt;

    constructor () payable {
        console.log("Bling Bling!");
        // Set the Initial seed
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function wave(string memory _message) public {

        // We need to make sure the current timestamp is at least 15-minutes bigger than the last time stamp
        require(
            lastWavedAt[msg.sender] + 30 seconds < block.timestamp,
            "Wait at least 30 seconds Fool"
        );

        // Update the current timestamp we have for the user
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s has waved w/ message %s", msg.sender, _message);

        // This is where I actually store the wave data in the array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        // Generate a new seed for the next user that sends wave
        seed = (block.difficulty + block.timestamp + seed) %100;

        console.log("Random # generated: %d", seed);

        // Give 50% chance that the users wins the prize
        if (seed <= 50) {
            console.log("%s won!", msg.sender);

        uint256 prizeAmount = 0.0001 ether;
        require(
            prizeAmount <= address(this).balance,
            "Trying to withdraw more money than the contract has."
        );
        (bool success, ) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw money from contract.");
        }

        // Google this fanciness
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    
    // Added function getAllWaves which will return the struct array, waves, to us.
    // This will make it easy to retrieve the waves from our website!
    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        return totalWaves;
    }
}