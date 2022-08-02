const database = require("../config").promise();

// GET ALL USERS
module.exports.getAllUsers = async (req, res) => {
  try {
    // Get all users
    const GET_USERS = `select * from user`;
    const [USERS] = await database.execute(GET_USERS);
    // Send response
    return res.status(200).send(USERS);
  } catch (error) {
    return res.status(500).send("Invalid Token");
  }
};

// GET USERS BY ID
module.exports.getUserById = async (req, res) => {
  const userId = req.params.userid;
  try {
    // Get user by ID
    const GET_USER_BY_ID = `
    select th.tcode, u.id, u.username, u.email, u.status, td.product_id, td.qty, p.name, p.price, th.status, ua.address, ua.postal, ua.province
    from user as u
    join user_address as ua on u.id = ua.user_id
    join transaction_header as th on u.id = th.user_id
    join transaction_detail as td on th.id = td.transaction_header_id
    join product as p on td.product_id = p.id
    where u.id = ?; 
    `;
    const [USER] = await database.execute(GET_USER_BY_ID, [userId]);
    // Send response
    return res.status(200).send(USER);
  } catch (error) {
    return res.status(500).send("Invalid Token");
  }
};

// DEACTIVATE USER
module.exports.deactivateUser = async (req, res) => {
  const userId = req.params.userid;

  try {
    // Change user Status
    const DEACTIVATE_USER = `update user set status = 'inactive' where id = ?`;
    await database.execute(DEACTIVATE_USER, [userId]);

    // send Respond
    res.status(200).send("User has been deactivated");
  } catch (error) {
    return res.status(500).send("Internal Service Error");
  }
};

// ACTIVATE USER
module.exports.activateUser = async (req, res) => {
  const userId = req.params.userid;

  try {
    // Change user Status
    const ACTIVATE_USER = `update user set status = 'active' where id = ?`;
    await database.execute(ACTIVATE_USER, [userId]);

    // send Respond
    res.status(200).send("User has been activated");
  } catch (error) {
    return res.status(500).send("Internal Service Error");
  }
};
