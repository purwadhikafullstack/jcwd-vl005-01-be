const routers = require("express").Router();

const { adminAuth } = require("../controllers");

routers.post("/auth/admin/login", adminAuth.loginAdmin);
routers.post("/auth/admin/forget-password", adminAuth.adminSendLinkResetPass);
routers.get(
  "/auth/admin/verify-link/:token",
  adminAuth.adminVerifyResetPassword
);
routers.patch("/auth/admin/change-password", adminAuth.adminSetNewPassword);
routers.post("/auth/admin/register", adminAuth.adminRegister);
routers.get(
  "/auth/admin/verify-account/:token",
  adminAuth.adminVerifyNewAccount
);
routers.get("/auth/admin/refresh-token/:admin_id", adminAuth.adminRefreshToken);

module.exports = routers;
