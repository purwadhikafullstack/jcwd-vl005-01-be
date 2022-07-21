const express = require("express");
const dotenv = require("dotenv");
const cors = require("cors");
const FileUpload = require("express-fileupload");
dotenv.config();

const database = require("./config");

// Define Main App
const app = express();

// Config Middlewares
app.use(express.json());
app.use(cors({ exposedHeaders: ["userToken", "authorization"] }));
app.use(FileUpload());
app.use(express.static("public"));

const bodyParser = require("body-parser");
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

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
app.use("/api", routers.user_router);
app.use("/api", routers.products_routers);
app.use("/api", routers.cart_router);

app.use('/api', routers.ProductRoute);
app.use('/api', routers.CategoryRoute);
app.use("/api", routers.adminManageUserRouter);
app.use("/api", routers.adminManageTransactionsRouter);
app.use("/api", routers.adminGenerateReport);

// binding to local port
const PORT = process.env.PORT;

app.listen(PORT, () => console.log(`API is Running at port ${PORT}`));
