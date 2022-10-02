const StoreAthletes = artifacts.require("StoreAthletes");

module.exports = function(deployer) {
  deployer.deploy(StoreAthletes);
};
