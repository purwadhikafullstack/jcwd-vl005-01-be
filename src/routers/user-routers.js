const routers = require("express").Router();

// import controllers
const { user_controller } = require('../controllers')

// define route
routers.post('/users/regis', user_controller.register)
// routers.get('/users', user_controller.getUsers)
// routers.get('/users/:id', user_controller.getUserById)
routers.get('/auth/verify/:token', user_controller.verifyAccount)
routers.post('/auth/refresh', user_controller.refreshToken)
routers.post('/auth/user/login', user_controller.login)
routers.get('/auth/user/keeplogin', user_controller.keepLogin)
routers.post("/auth/user/forget-password", user_controller.userCheckEmailResPass);
routers.get("/auth/user/verify-resetpass/:token",user_controller.userVerifyResetPassword);
routers.patch("/auth/user/change-password", user_controller.userSetNewPassword);

// export * module
module.exports = routers;