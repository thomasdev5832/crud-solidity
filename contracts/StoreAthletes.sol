// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract StoreAthletes {

    struct Athlete {
        string name;
        uint8 age;
        uint8 height;
        uint8 weight;
    }

    uint32 private nextId = 0;
    uint32 public count = 0; 

    function getNextId() private returns(uint32) {
        return ++nextId;
    }

    mapping (uint32 => Athlete) public athletes;

    function addAthlete(Athlete memory newAthlete) public {
        athletes[getNextId()] = newAthlete;
        count++;
    }

    function getAthlete(uint32 id) public view returns(Athlete memory){
        return athletes[id];
    }

    function compareStrings(string memory a, string memory b) private pure returns(bool) {
        return keccak256(bytes(a)) == keccak256(bytes(b));
    }

    function editAthlete(uint32 id, Athlete memory newAthlete) public {
        Athlete memory oldAthlete = athletes[id];
        if(oldAthlete.age == 0) return;

        if(newAthlete.age > 0 && oldAthlete.age != newAthlete.age)
            oldAthlete.age = newAthlete.age;

        if(bytes(newAthlete.name).length > 0 && !compareStrings(oldAthlete.name, newAthlete.name))
            oldAthlete.name = newAthlete.name;

        if(newAthlete.height > 0 && oldAthlete.height != newAthlete.height)
            oldAthlete.height = newAthlete.height;

        if(newAthlete.weight > 0 && oldAthlete.weight != newAthlete.weight)
            oldAthlete.weight = newAthlete.weight;

        athletes[id] = oldAthlete;

    }

    function removeAthlete(uint32 id) public {
        Athlete memory oldAthlete = athletes[id];
        if(bytes(oldAthlete.name).length > 0) {
            delete athletes[id];
            count--;
        }
    }

}
