const routers = require("express").Router();

const { adminManageUser } = require("../controllers");
const authMiddleware = require("../helpers/adminAuthMiddleware");

routers.get("/admin/getusers", authMiddleware, adminManageUser.getAllUsers);
routers.get(
  "/admin/getuser/:userid",
  authMiddleware,
  adminManageUser.getUserById
);
routers.get(
  "/admin/deactivate-user/:userid",
  authMiddleware,
  adminManageUser.deactivateUser
);
routers.get(
  "/admin/activate-user/:userid",
  authMiddleware,
  adminManageUser.activateUser
);

module.exports = routers;
