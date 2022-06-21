const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");
dotenv.config();

const database = require("./config");

// Define Main App
const app = express();

// Config Middlewares
app.use(express.json());
app.use(cors({ exposedHeaders: ["authorization"] }));

// test database connection

database.connect((error) => {
  if (error) {
    console.log("Error ,", error);
  }
  console.log(`database is connected, threadId: ${database.threadId}`);
});

// define main route

app.get("/", (req, res) => {
  res.status(200).send("<h1>Welcome to Instore API</h1>");
});

// routers
const routers = require("./routers");

app.use("/api", routers.adminAuthRouter);

// binding to local port
const PORT = process.env.PORT;

app.listen(PORT, () => console.log(`API is Running at port ${PORT}`));
