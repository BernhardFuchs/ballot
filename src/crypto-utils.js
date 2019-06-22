const filename = process.argv[2];
const crypto = require("crypto");
const fs = require("fs");

const hash = crypto.createHash("sha256");

const input = fs.createReadStream(filename);
input.on("readable", () => {
  // Only one element is going to be produced by the
  // hash stream.
  const data = input.read();
  if (data) hash.update(data);
  else {
    console.log(`${hash.digest("hex")} ${filename}`);
  }
});
