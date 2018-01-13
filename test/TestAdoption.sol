pragma solidity ^0.4.18;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Adoption.sol";


contract TestAdoption {
  Adoption adoption = Adoption(DeployedAddresses.Adoption());
  uint validPetId = 8;

  function testUserCanAdoptPet() public {
    uint returnedId = adoption.adopt(validPetId);

    Assert.equal(returnedId, validPetId, "Should return id of adopted pet.");
  }

  function testGetAdopterAddressByPetId() public {
    address contractCaller = this;

    address adopter = adoption.adopters(validPetId);

    Assert.equal(adopter, contractCaller, "Owner of the pet should be recorded.");
  }

  function testGetAdopterAddressByPetIdInArray() public {
    address contractCaller = this;

    address[16] memory adopters = adoption.getAdopters();

    Assert.equal(adopters[validPetId], contractCaller, "Owner of pet should be recorded.");
  }

  function testOtherAdopterAddressesAreEmpty() public {
    address[16] memory adopters = adoption.getAdopters();

    for (uint i = 0; i < 16; i++) {
      if (i == validPetId) {continue;}
      Assert.equal(adopters[i], 0, "Other adressed are empty.");
    }
  }
}
