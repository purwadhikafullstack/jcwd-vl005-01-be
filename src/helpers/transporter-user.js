const nodemailer = require("nodemailer");

module.exports = nodemailer.createTransport({
  service: "gmail",
  auth: {
    user: "bowotp@gmail.com",
    pass: process.env.MAIL_PASS,
  },
  tls: { rejectUnauthorized: false },
});
