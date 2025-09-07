const express = require("express");
const dotenv = require("dotenv");
const connectDB = require("./config/db");
const cors = require("cors");
const bodyParser = require("body-parser");


dotenv.config();

const app = express();
app.use(bodyParser.json());
app.use(cors());

app.get("/", (req, res) => {
  res.send("Backend is running....");
});


const authRoutes = require("./routes/auth");
const loanRoutes = require("./routes/loan");


app.use("/auth", authRoutes);  
app.use("/loan", loanRoutes);  


const PORT = 8000;
const HOST = "0.0.0.0";

connectDB().then(() => {
  app.listen(PORT,HOST, () => {
  console.log(`Server started on http://${HOST}:${PORT}`);
  });
});
