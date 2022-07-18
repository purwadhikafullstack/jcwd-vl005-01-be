const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  const token = req.header("authorization");

  try {
    // 1. Authenticate, harus udah login
    if (!token) {
      return res.status(401).send("Unauthorized");
    }
    // 2. verify token
    const { admin_id } = jwt.verify(token, process.env.JWT_PASS);
    // 3. Modify object req
    req.admin_id = admin_id;
    next();
  } catch (error) {
    return res.status(400).send(error.message);
  }
};
