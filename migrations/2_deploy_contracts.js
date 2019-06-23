const Ballot = artifacts.require("Ballot");
const crypto = require("crypto");

module.exports = deployer => {
  const serverHash = crypto.createHash("sha256");
  serverHash.update("SomeServerNameHash");

  const settingsHash = crypto.createHash("sha256");
  settingsHash.update("SomeSettingsHash");

  deployer.deploy(
    Ballot,
    `0x${serverHash.digest("hex")}`,
    `0x${settingsHash.digest("hex")}`
  );
};
