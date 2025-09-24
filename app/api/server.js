const express = require("express");
const app = express();
const PORT = process.env.PORT || 3000;

app.get("/api/hello", (req, res) => {
  res.json({ message: "Hello from Kubernetes API 🚀" });
});

app.listen(PORT, () => {
  console.log(`API running on port ${PORT}`);
});
