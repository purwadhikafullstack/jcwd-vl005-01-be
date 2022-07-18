const uuid = require('uuid')
const bcrypt = require('bcrypt')
// const { totp } = require('otplib')
const jwt = require('jsonwebtoken')
const transporter = require('../helpers/transporter-user')
const database = require('../config').promise()
const { userSetNewPassword, registerSchema } = require('../helpers/validation-schema')

//REGISTER NEW USER
module.exports.register = async (req, res) => {
    const { username, email, password, confirm_password } = req.body
    try {
        if (username === "" || email === "" || password === "" || confirm_password === "") {
            return res.status(404).send('Please fill all the empty box')
        }
        
        // 1. validate -> match password with repeat password
        if (password !== confirm_password) {
            return res.status(404).send(`password doesn't match.`)
        }

        // 2. validate value of req.body -> according to our schema
        const { error } = registerSchema.validate(req.body)
        if (error) {
            return res.status(400).send(error.details[0].message)
        }

        // 3. check if username and email is unique?
        const CHECK_USER = `SELECT * FROM user WHERE username = ?;`
        const [ USER ] = await database.execute(CHECK_USER, [username])
        if (USER.length) {
            return res.status(400).send('Username already registered.')
        }
        const CHECK_CEMAIL = `SELECT * FROM user WHERE email = ?;`
        const [ CEMAIL ] = await database.execute(CHECK_CEMAIL, [email])
        if (CEMAIL.length) {
            return res.status(400).send('Email already registered.')
        }

        // 4. create Unique ID
        const id = uuid.v4()
        console.log('user id : ', id)

        // 5. HASH password
        const salt = await bcrypt.genSalt(10)
        const hashed_password = await bcrypt.hash(password, salt)
        console.log('plain : ', password)
        console.log('hashed :', hashed_password)

        // 6. store data into our database
        const INSERT_USER = `
            INSERT INTO user (id, username, email, password)
            VALUES(${database.escape(id)}, ${database.escape(username)}, ${database.escape(email)}, ${database.escape(hashed_password)});
        `
        const [ INFO ] = await database.execute(INSERT_USER)
        // 6. store data into our database USER ADDRESS
        const INSERT_PROFILE = `
            INSERT INTO user_address (User_id)
            VALUES(${database.escape(id)});
        `
        const [ INFO_PROFILE ] = await database.execute(INSERT_PROFILE)

        // 7. generate TOKEN -> OTP
        // totp.options = { epoch : 0, step : 300 }
        const token = jwt.sign(
            { userId: id },
            process.env.JWT_PASS,
            {
            expiresIn: "300000s",
            }
        );
        console.log(token);
        
        // store token to database
        const INSERT_TOKEN = `INSERT INTO token (User_id, token) VALUES (${database.escape(id)}, ${database.escape(token)});`
        const [ INFO_TOKEN ] = await database.execute(INSERT_TOKEN) 

        // 8. send otp to client -> via email        
        const TRANSPORTER_INFO = await transporter.sendMail({
            from : 'Instore <bowotp@gmail.com>',
            to : `${email}`,
            subject : 'User Verification',
            html: 
            `
                <h1 style="text-align: center;">Welcome New User</h1>
                <p>Thank you for register to our website, please proceed to activate your account.</p>
                <a href='http://localhost:5000/api/auth/verify/${token}'>Click here to proceed verify</a>
            `
        })

        res.header('userId', id).status(200).send("Registration Successfull")
    } catch (error) {
        console.log("error :", error);
        return res.status(500).send("Internal service Error");
    }
}

// verify account
module.exports.verifyAccount = async (req, res) => {
    // const uid = req.header('uid')
    const token = req.params.token
    console.log(token)
    try {        
        const CHECK_TOKEN = `SELECT token FROM token WHERE token = ?;`
        const [ TOKEN ] = await database.execute(CHECK_TOKEN, [token])
        if (!TOKEN.length) {
            return res.status(400).send('token invalid.')
        }

        // validate token
        const CheckVToken = jwt.verify(token, process.env.JWT_PASS)
        console.log(CheckVToken.userId);
        if (!CheckVToken.userId.length) {
            return res.status(400).send('token expired.')
        }

        const CHECK_UID = `SELECT User_id FROM token WHERE token = ?;`
        const [cuid] = await database.execute(CHECK_UID, [token])
        const arruid = cuid[0]
        const uid = arruid.User_id
        console.log('userId :', uid);

        // change status
        const UPDATE_STATUS = `UPDATE user SET is_active = 1 WHERE id = ?;`
        const [ INFO ] = await database.execute(UPDATE_STATUS, [uid])

        // delete token
        const DELETE_TOKEN = `DELETE FROM token WHERE User_id = ?;`
        const [ INFO_DELETE ] = await database.execute(DELETE_TOKEN, [uid])

        // create respond
        res.status(200).redirect(301, 'http://localhost:3000/verified')

    } catch (error) {
        console.log("error :", error);
        return res.status(500).send(error.message);
    }
}

module.exports.refreshToken = async (req, res) => {
    const {email} = req.body
    try {
        if (email === "") {
            return res.status(404).send("Email cannot be empty")
        }

        //2. Check if Email is registered
        const CHECK_EMAIL = `select * from user where email = ?`;
        const [EMAIL] = await database.execute(CHECK_EMAIL, [email]);
        if (!EMAIL.length) {
            return res.status(404).send("Email is not registered");
        }

        // // if token exist -> check if token still valid or not
        // const created = new Date(TOKEN[0].createdAt).getTime()
        // const now = new Date().getTime()
        // const step = now - created
        // const remaining_time = Math.floor((60000 - step) / 1000)
        // // if token still valid and not yet expired
        // if (step <= 60000) {
        //     throw new createError(http_status.BAD_REQUEST, `please wait for ${remaining_time}s to refresh your token.`)
        // }

        const CHECK_UID = `SELECT id FROM user WHERE email = ?;`
        const [cuid] = await database.execute(CHECK_UID, [email])
        const arruid = cuid[0]
        const UID = arruid.uid
        console.log('userId :', UID);

        // get email
        // const GET_EMAIL = `SELECT email FROM user WHERE uid = ?;`
        // const [ EMAIL ] = await database.execute(GET_EMAIL, [UID])
        // const arrmail = EMAIL[0]
        // const mail = arrmail.email
        // console.log(mail);


        // if token has been expired -> update token
        const token = jwt.sign(
            { userId: cuid[0].id },
            process.env.JWT_PASS,
            {
            expiresIn: "180s",
            }
        );
        console.log(token);
        console.log(userId);

        const UPDATE_TOKEN = `UPDATE token SET token = ?, createdAt = ? WHERE User_id = ?;`
        const [ INFO ] = await database.execute(UPDATE_TOKEN, [token, new Date(), UID])

        // send token to client email
        const TRANSPORTER_INFO = await transporter.sendMail({
            from : 'Admin Dimasocial <bowotp@gmail.com>',
            to : `${mail}`,
            subject : 'OTP Verification',
            html: 
            `
                <p>Your Verification Code is ${token}, do not share to others.</p>
                <a href='http://localhost:5000/api/auth/verify/${token}'>Click here to proceed verify</a>
            `
        })

        // create respond
        res.status(200).send("respond")
    } catch (error) {
        console.log("error :", error);
        return res.status(500).send("Internal service Error");
    }
}


// LOGIN
module.exports.login = async (req, res) => {
    const { usernameOrEmail, password } = req.body
    try {
        if (!usernameOrEmail.length) {
            return res.status(404).send('Username or Email canot be empty')
        }
        if (!password.length) {
            return res.status(404).send('Password canot be empty')
        }
        
        // 2. validate username or email in our database
        const CHECK_USER = `SELECT * FROM user WHERE username=? OR email=?;`
        const [ USER ] = await database.execute(CHECK_USER, [usernameOrEmail, usernameOrEmail])
        if (!USER.length) {
            return res.status(404).send('User or Email has not been registered.')
        }
        
        // 3. if user already resgitered => validate password - OPEN WHEN PASS ALREADY HASH
        const isValid = await bcrypt.compare(password, USER[0].password)
        if(!isValid) {
            return res.status(404).send("Invalid Password!")
        }

        // 4. if password valid, -> create token using JWT
        const token = jwt.sign({ userId : USER[0].id }, process.env.JWT_PASS)
        console.log('login token:', token)

        // 5. create respond and sent token to client
        delete USER[0].password
        USER[0].token = token
        logindata = USER[0]
        
        // res.header('userToken', `Bearer ${token}`).status(200).send(logindata)
        res.status(200).send(logindata)
    } catch (error) {
        console.log("error :", error);
        return res.status(500).send("Internal service Error")
    }
}

// KEEPLOGIN -> FRONTEND WANT TO RETRIEVE USER'S DATA AFTER PAGE REFRSHED
module.exports.keepLogin = async (req, res) => {
    const token = req.header('authorization')
    try {
        // check token
        if (!token) {
            return res.status(401).send("Token is required")
        }

        // if token exist -> validate token
        const { userId } = jwt.verify(token, process.env.JWT_PASS)
        if (!userId) {
            return res.status(400).send("Invalid Token")
        }

        // if token valid => retrieve user's data
        const GET_USER = `SELECT * FROM user WHERE id = ?;`
        const [ USER ] = await database.execute(GET_USER, [userId])

        // create respond
        delete USER[0].password
        
        res.status(200).send(USER[0])
        // res.status(200).send(USER[0]).redirect(301, 'http://localhost:3000/')
    } catch (error) {
        console.log("error :", error);
        return res.status(500).send("Internal Service Error");
    }
}

//reset password, 1. check email and password, pass and newpass, to sent token
module.exports.userCheckEmailResPass = async (req, res) => {
    const {email} = req.body;
    try {
        if (email === "") {
            return res.status(404).send("Email cannot be empty")
        }

        //2. Check if Email is registered
        const CHECK_EMAIL = `select * from user where email = ?`;
        const [EMAIL] = await database.execute(CHECK_EMAIL, [email]);
        if (!EMAIL.length) {
            return res.status(404).send("Email is not registered");
        }
        //3. generate token
        const token = jwt.sign(
            { userId: EMAIL[0].id },
            process.env.JWT_PASS,
            {
            expiresIn: "180s",
            }
        );
        console.log(token);

        //4. Send Email
        await transporter.sendMail({
            from: "'Instore' <bowotp@gmail.com>",
            to: EMAIL[0].email,
            subject: "Reset Password Confirmation",
            html: `
                <h1 style="text-align: center;">Reset Your Password</h1>
                <p>We have received your request to reset the password for your account</p>
                <a href='http://localhost:3000/user/reset-pass/${token}'>Click here to set new password</a>
                `,
            });
        res.status(200).send("Email has been sent to reset your password");
    } catch (error) {
        console.log("error :", error);
        return res.status(500).send("Internal service Error");
    }
};

// USER FORGET PASSWORD
///// VERIFY RESET PASSWORD LINK

module.exports.userVerifyResetPassword = async (req, res) => {
    const token = req.params.token;

    try {
        try {
        const { userId } = jwt.verify(token, process.env.JWT_PASS);
            return res.json({ status: 200, userId: userId });
        } catch (error) {
        return res.status(400).send(error.message);
        }
    } catch (error) {
        return res.status(500).send("Internal service Error");
    }
};

// USER FORGET PASSWORD
///// SET NEW PASSWORD

module.exports.userSetNewPassword = async (req, res) => {
    const { password, userId, confirm_password } = req.body;
    try {
        // 1. verify password & confirm password
        if (password === "" || confirm_password === "" ) {
            return res.status(400).send("Please fill all the empty box")
        }
        if (password !== confirm_password) {
            return res
            .status(400)
            .send("Password and confirm password doesn't match");
        }

        // 2. Validate New Password
        const { error } = userSetNewPassword.validate(req.body);
        if (error) {
            return res.status(400).send(error.details[0].message);
        }

        // 3. Verify userId
        const CHECK_USER = `select * from user WHERE id = ?`;
        const [USER] = await database.execute(CHECK_USER, [userId]);
        if (!USER.length) {
            return res.status(404).send("Account is not found");
        }

        // 4. Hash New Password
        const salt = await bcrypt.genSalt(10);
        const hashedPassword = await bcrypt.hash(password, salt);

        // 5. Update Password
        const UPDATE_PASSWORD = `UPDATE user SET password = ? WHERE id = ?`;
        await database.execute(UPDATE_PASSWORD, [hashedPassword, userId]);

        res.status(200).send("Password Has Been Changed");
    } catch (error) {
        return res.status(500).send("Internal service Error");
    }
};
