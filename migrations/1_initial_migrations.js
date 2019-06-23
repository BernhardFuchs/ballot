"use strict";
exports.__esModule = true;
var Migrations = artifacts.require("Migrations");
var Ballot = artifacts.require("Ballot");
module.exports = function (deployer) {
    deployer.deploy(Migrations);
    deployer.deploy(Ballot, "0xserverNameHash", "0xinitialSettingsHash");
};
