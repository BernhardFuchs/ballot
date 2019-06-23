const Migrations = artifacts.require("Migrations");
const Ballot = artifacts.require("Ballot");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Ballot, "0xserverNameHash", "0xinitialSettingsHash");
} as Truffle.Migration;

// because of https://stackoverflow.com/questions/40900791/cannot-redeclare-block-scoped-variable-in-unrelated-files
export {};
