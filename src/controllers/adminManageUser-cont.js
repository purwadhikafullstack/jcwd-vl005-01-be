const database = require("../config").promise();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const uuid = require("uuid");

// GET ALL USERS
module.exports.getAllUsers = async (req, res) => {
  const token = req.header("authorization");

  try {
    // 1. Authenticate, harus udah login
    if (!token) {
      return res.status(401).send("Unauthorized");
    }
    // 2. verify token
    jwt.verify(token, process.env.JWT_PASS);

    // 3. Get all users
    const GET_USERS = `select * from user`;
    const [USERS] = await database.execute(GET_USERS);
    // 4. Send response
    return res.status(200).send(USERS);
  } catch (error) {
    return res.status(500).send("Invalid Token");
  }
};

// GET USERS BY ID
module.exports.getUserById = async (req, res) => {
  const token = req.header("authorization");
  const userId = req.params.userid;
  try {
    // 1. Authenticate, harus udah login
    if (!token) {
      return res.status(401).send("Unauthorized");
    }
    // 2. verify token
    jwt.verify(token, process.env.JWT_PASS);

    // 3. Get user by ID
    const GET_USER_BY_ID = `select * from user where user_id = ?`;
    const [USER] = await database.execute(GET_USER_BY_ID, [userId]);
    // 4. Send response
    return res.status(200).send(USER[0]);
  } catch (error) {
    return res.status(500).send("Invalid Token");
  }
};

// DEACTIVATE USER
module.exports.deactivateUser = async (req, res) => {
  const token = req.header("authorization");
  const userId = req.params.userid;

  try {
    // 1. Authenticate, harus udah login
    if (!token) {
      return res.status(401).send("Unauthorized");
    }
    // 2. verify token
    jwt.verify(token, process.env.JWT_PASS);

    // 3. Change user Status
    const DEACTIVATE_USER = `update user set status = 'inactive' where user_id = ?`;
    await database.execute(DEACTIVATE_USER, [userId]);

    //4. send Respond
    res.status(200).send("User has been deactivated");
  } catch (error) {
    return res.status(500).send("Internal Service Error");
  }
};
