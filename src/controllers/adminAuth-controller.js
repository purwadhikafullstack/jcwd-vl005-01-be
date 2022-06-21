const database = require("../config").promise();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const {
  adminUsernameLoginSchema,
  adminEmailLoginSchema,
  adminSendResetPassEmailSchema,
  adminSetNewPassword,
} = require("../helpers/validation-schema");
const transporter = require("../helpers/transporter");

// ADMIN LOGIN
module.exports.loginAdmin = async (req, res) => {
  const { user, password } = req.body;

  try {
    // 1. Validate Req Body
    if (user.includes("@")) {
      const { error } = adminEmailLoginSchema.validate(req.body);
      if (error) {
        return res.status(400).send(error.details[0].message);
      }
    } else {
      const { error } = adminUsernameLoginSchema.validate(req.body);
      if (error) {
        return res.status(400).send(error.details[0].message);
      }
    }
    // 2. Check if user is exist

    const CHECK_ADMIN = `select * from admin where username = ? or email = ?`;
    const [ADMIN] = await database.execute(CHECK_ADMIN, [user, user]);
    if (!ADMIN.length) {
      return res.status(400).send("Username or Email Not Found");
    }
    // 3. if user exist, compare password
    const valid = await bcrypt.compare(password, ADMIN[0].password);
    if (!valid) {
      return res.status(400).send("Wrong Password!");
    }

    // 4. create login token
    const token = jwt.sign(
      { adminId: ADMIN[0].admin_id },
      process.env.JWT_PASS
    );
    delete ADMIN[0].password;

    res.header("authorization", `Bearer ${token}`).status(200).send(ADMIN[0]);
  } catch (error) {
    console.log("error :", error);
    return res.status(500).send("Internal service Error");
  }
};

// ADMIN KEEP LOGIN

module.exports.keepLoginAdmin = async (req, res) => {
  const token = req.header("authorization");

  try {
    // 1. CHECK IF REQ CONTAINS TOKEN
    if (!token) {
      return res.status(400).send("Unauthorized");
    }
    // 2. IF TOKEN EXIST, VALIDATE TOKEN
    const { adminId } = jwt.verify(token, process.env.JWT_PASS);
    if (!adminId) {
      return res.status(400).send("Invalid Token");
    }
    // 3. IF TOKEN VALID, DO QUERY TO GET USER DATA
    const GET_ADMIN = `select * from admin where admin_id = ?`;
    const [ADMIN] = await database.execute(GET_ADMIN, [adminId]);
    // 4. CREATE RESPOND
    delete ADMIN[0].password;
    return res.status(200).send(ADMIN[0]);
  } catch (error) {
    console.log("error :", error);
    return res.status(500).send(error.message);
  }
};

// ADMIN FORGET PASSWORD
///// SEND LINK TO REGISTERED EMAIL

module.exports.adminSendLinkResetPass = async (req, res) => {
  const body = req.body;

  try {
    //1. Validate Email
    const { error } = adminSendResetPassEmailSchema.validate(body);
    if (error) {
      return res.status(400).send(error.details[0].message);
    }
    //2. Check if Email is registered
    const CHECK_EMAIL = `select * from admin where email = ?`;
    const [EMAIL] = await database.execute(CHECK_EMAIL, [body.email]);
    if (!EMAIL.length) {
      return res.status(404).send("Email is not registered");
    }
    //3. generate token
    const token = jwt.sign(
      { adminId: EMAIL[0].admin_id },
      process.env.JWT_PASS,
      {
        expiresIn: "180s",
      }
    );

    //4. Send Email
    await transporter.sendMail({
      from: "'Instore' <aldysprima.soc@gmail.com>",
      to: EMAIL[0].email,
      subject: "Reset Password Confirmation",
      html: `
        <h1 style="text-align: center;">Reset Your Password</h1>
        <p>We have received your request to reset the password for your account</p>
        <p>To reset your password, click on the link below</p>
        <p>${process.env.CLIENT_URL}/admin/reset-password/${token}</p>
        `,
    });
    res.status(200).send("Email has been sent to reset your password");
  } catch (error) {
    console.log("error :", error);
    return res.status(500).send("Internal service Error");
  }
};

// ADMIN FORGET PASSWORD
///// VERIFY RESET PASSWORD LINK

module.exports.adminVerifyResetPassword = async (req, res) => {
  const token = req.params.token;

  try {
    try {
      const { adminId } = jwt.verify(token, process.env.JWT_PASS);
      return res.json({ status: 200, adminId: adminId });
    } catch (error) {
      return res.status(400).send(error.message);
    }
  } catch (error) {
    return res.status(500).send("Internal service Error");
  }
};

// ADMIN FORGET PASSWORD
///// SET NEW PASSWORD

module.exports.adminSetNewPassword = async (req, res) => {
  const { password, adminId, confirm_password } = req.body;
  try {
    // 1. verify password & confirm password
    if (password !== confirm_password) {
      return res
        .status(400)
        .send("Password and confirm password doesn't match");
    }

    // 2. Validate New Password
    const { error } = adminSetNewPassword.validate(req.body);
    if (error) {
      return res.status(400).send(error.details[0].message);
    }

    // 3. Verify AdminID
    const CHECK_ADMIN = `select * from admin where admin_id = ?`;
    const [ADMIN] = await database.execute(CHECK_ADMIN, [adminId]);
    if (!ADMIN.length) {
      return res.status(404).send("Account is not found");
    }

    // 4. Hash New Password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // 5. Update Password
    const UPDATE_PASSWORD = `update admin set password = ? where admin_id = ?`;
    await database.execute(UPDATE_PASSWORD, [hashedPassword, adminId]);

    res.status(200).send("Password Has Been Changed");
  } catch (error) {
    return res.status(500).send("Internal service Error");
  }
};
