const routers = require("express").Router();

const { adminManageUser } = require("../controllers");

routers.get("/admin/getusers", adminManageUser.getAllUsers);
routers.get("/admin/getuser/:userid", adminManageUser.getUserById);
routers.get("/admin/deactivate-user/:userid", adminManageUser.deactivateUser);
routers.get("/admin/activate-user/:userid", adminManageUser.activateUser);

module.exports = routers;
