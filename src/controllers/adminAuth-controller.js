const database = require("../config").promise();
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const uuid = require("uuid");
const {
  adminUsernameLoginSchema,
  adminEmailLoginSchema,
  adminSendResetPassEmailSchema,
  adminSetNewPassword,
  adminRegisterSchema,
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
      {
        admin_id: ADMIN[0].admin_id,
        username: ADMIN[0].username,
        email: ADMIN[0].email,
        status: ADMIN[0].status,
      },
      process.env.JWT_PASS
    );
    delete ADMIN[0].password;

    res.header("authorization", `Bearer ${token}`).status(200).send(ADMIN[0]);
  } catch (error) {
    return res.status(500).send("Internal service Error");
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
      { admin_id: EMAIL[0].admin_id },
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
    return res.status(500).send("Internal service Error");
  }
};

// ADMIN FORGET PASSWORD
///// VERIFY RESET PASSWORD LINK

module.exports.adminVerifyResetPassword = async (req, res) => {
  const token = req.params.token;

  try {
    try {
      const { admin_id } = jwt.verify(token, process.env.JWT_PASS);
      return res.json({ status: 200, admin_id: admin_id });
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
  const { password, admin_id, confirm_password } = req.body;
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

    // 3. Verify admin_id
    const CHECK_ADMIN = `select * from admin where admin_id = ?`;
    const [ADMIN] = await database.execute(CHECK_ADMIN, [admin_id]);
    if (!ADMIN.length) {
      return res.status(404).send("Account is not found");
    }

    // 4. Hash New Password
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // 5. Update Password
    const UPDATE_PASSWORD = `update admin set password = ? where admin_id = ?`;
    await database.execute(UPDATE_PASSWORD, [hashedPassword, admin_id]);

    res.status(200).send("Password Has Been Changed");
  } catch (error) {
    return res.status(500).send("Internal service Error");
  }
};

// ADMIN REGISTER
///// POST NEW ACCOUNT AND SEND EMAIL VERIFICATION
module.exports.adminRegister = async (req, res) => {
  const { username, email, password, confirm_password } = req.body;

  try {
    // 1. VERIFY PASSWORD & CONFIRM PASSWORD
    if (password !== confirm_password) {
      return res
        .status(400)
        .send("Password and confirm password doesn't match");
    }
    // 2. VERIFY REQ BODY BY SCHEMA
    const { error } = adminRegisterSchema.validate(req.body);
    if (error) {
      return res.status(400).send(error.details[0].message);
    }
    // 3. VERIFY USERNAME UNIQUENESS
    const CHECK_USERNAME = `select * from admin where username = ?`;
    const [USERNAME] = await database.execute(CHECK_USERNAME, [username]);
    if (USERNAME.length) {
      return res.status(400).send("Username is already exist");
    }
    // 4. VERIFY EMAIL UNIQUENESS
    const CHECK_EMAIL = `select * from admin where email = ?`;
    const [EMAIL] = await database.execute(CHECK_EMAIL, [email]);
    if (EMAIL.length) {
      return res.status(400).send("Email is already exist");
    }
    // 5. GENERATE ADMIN ID
    const admin_id = uuid.v4();

    // 6. HASH PASSWORD
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(password, salt);

    // 7. INSERT TO DB
    const INSERT_ADMIN = `insert into admin(admin_id, username, email, password) values(?, ?, ?, ?)`;
    const [INFO] = await database.execute(INSERT_ADMIN, [
      admin_id,
      username,
      email,
      hashedPassword,
    ]);
    // 8. CREATE WEB TOKEN
    const token = jwt.sign({ admin_id: admin_id }, process.env.JWT_PASS);

    // 9. STORE TOKEN
    const STORE_TOKEN = `insert into registration_token(user_id, token) values(?, ?)`;
    await database.execute(STORE_TOKEN, [admin_id, token]);

    // 9. SEND VERIF EMAIL

    await transporter.sendMail({
      from: "'Instore' <aldysprima.soc@gmail.com>",
      to: email,
      subject: "Verify Your Account ",
      html: `
      <h1 style="text-align: center;">Dear Admin</h1>
      <p style="text-align: center;">Please click link below to verify your account</p>
      <p style="text-align: center;">Warm Regards</p>
      <p>${process.env.CLIENT_URL}/admin/verify-account/${token}</p>
      `,
    });
    res
      .status(201)
      .send("Account Has Been Created, Please verify Your Account");
  } catch (error) {
    console.log("Error :", error);
    return res.status(500).send("Internal service Error");
  }
};

// ADMIN REGISTER
///// VERIFY NEW ACCOUNT
module.exports.adminVerifyNewAccount = async (req, res) => {
  const token = req.params.token;
  try {
    // 1. Check if token exist
    const CHECK_TOKEN = `select * from registration_token where token = ?`;
    const [TOKEN] = await database.execute(CHECK_TOKEN, [token]);
    if (!TOKEN.length) {
      return res.status(400).send("Token isn't valid");
    }
    // 2. Validate Token
    const { admin_id } = jwt.verify(token, process.env.JWT_PASS);
    // 3. Change Admin Status
    const UPDATE_ADMIN_STATUS = `update admin set status = 'verified' where admin_id = ?`;
    await database.execute(UPDATE_ADMIN_STATUS, [admin_id]);
    // 4. DELETE TOKEN
    const DELETE_TOKEN =
      "delete from registration_token where user_id = ? and token = ?";
    await database.execute(DELETE_TOKEN, [admin_id, token]);
    // 5. Send Respond
    return res.status(200).send("Account has been verified");
  } catch (error) {
    return res.status(500).send(error.name);
  }
};

//Admin register
/////Send Refresh Token
module.exports.adminRefreshToken = async (req, res) => {
  const admin_id = req.params.admin_id;
  try {
    // 1. CHECK IF THE TOKEN IS EXIST
    const CHECK_TOKEN = `select * from registration_token where user_id = ?`;
    const [TOKEN] = await database.execute(CHECK_TOKEN, [admin_id]);
    if (!TOKEN.length) {
      return res.status(404).send("Token Is Invalid");
    }
    // 2. Prevent User from resending request simultaneously
    const current = new Date().getTime();
    const created = new Date(TOKEN[0].created_at).getTime();
    const step = current - created;
    const remaining = Math.floor((300000 - step) / 1000);
    if (step < 300000) {
      return res
        .status(400)
        .send(`Please wait for ${remaining}s to refresh token`);
    }

    // 3. CREATE NEW TOKEN
    const newToken = jwt.sign({ admin_id: admin_id }, process.env.JWT_PASS);
    const now = new Date();

    // 4. UPDATE TO DATABASE
    const UPDATE_TOKEN = `UPDATE registration_token set token = ?, created_at = ? where user_id = ?`;
    await database.execute(UPDATE_TOKEN, [newToken, now, admin_id]);

    // 5. SEND NEW TOKEN TO CLIENT
    const GET_USER_EMAIL = `SELECT email from admin where admin_id = ?`;
    const [EMAIL] = await database.execute(GET_USER_EMAIL, [admin_id]);

    await transporter.sendMail({
      from: "'Instore' <aldysprima.soc@gmail.com>",
      to: EMAIL[0].email,
      subject: "Verify Your Account ",
      html: `
      <h1 style="text-align: center;">Dear Admin</h1>
      <p style="text-align: center;">Please click link below to verify your account</p>
      <p style="text-align: center;">Warm Regards</p>
      <p>${process.env.CLIENT_URL}/admin/verify-account/${newToken}</p>
      `,
    });

    // 6. CREATE RESPOND
    res
      .status(200)
      .send("Refresh Token has been sent. Kindly check your email");
  } catch (error) {
    console.log("error :", error);
    return res.status(500).send("Internal service Error");
  }
};
