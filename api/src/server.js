const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

mongoose.connect(process.env.MONGO_URI);

app.use("/todos", require("./routes/todos"));

app.get("/", (req, res) => {
  res.send("Todo API Running");
});

app.listen(3000, () => {
  console.log("Server running on port 3000");
});
