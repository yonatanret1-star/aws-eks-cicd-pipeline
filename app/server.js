const express = require("express");

const app = express();
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello from GitOps!");
});

app.listen(port, "0.0.0.0", () => {
  console.log(`Application running on port ${port}`);
});