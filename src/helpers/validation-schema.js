const joi = require("joi");
const { joiPassword } = require("joi-password");

module.exports.adminUsernameLoginSchema = joi.object({
  user: joi.string().alphanum().required(),
  password: joi.string().required(),
});

module.exports.adminEmailLoginSchema = joi.object({
  user: joi.string().email().required(),
  password: joi.string().required(),
});

module.exports.adminSendResetPassEmailSchema = joi.object({
  email: joi.string().email().required(),
});

module.exports.adminSetNewPassword = joi.object({
  password: joiPassword
    .string()
    .min(8)
    .minOfSpecialCharacters(1)
    .minOfUppercase(1)
    .minOfNumeric(1)
    .required(),
  confirm_password: joi.ref("password"),
  adminId: joi.string().required(),
});
