const filename = process.argv[2];
const crypto = require("crypto");
const fs = require("fs");

const serverNameHash = () => {
  const hash = crypto.createHash("sha256");
  const input = fs.createReadStream(filename);
  input.on("readable", () => {
    // Only one element is going to be produced by the
    // hash stream.
    const data = input.read();
    if (data) {
      const serverName = JSON.parse("serverName");
      console.log(`serverName: ${serverName}`);
      hash.update(serverName);
    } else {
      const digest = hash.digest("hex");
      console.log(`${digest} ${filename}`);
      return digest;
    }
  })
}

module.exports = serverNameHash;
