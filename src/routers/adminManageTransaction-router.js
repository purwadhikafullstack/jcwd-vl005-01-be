const routers = require("express").Router();

const { adminManageTransactions } = require("../controllers");
const authMiddleware = require("../helpers/adminAuthMiddleware");

routers.get(
  "/admin/transactions",
  authMiddleware,
  adminManageTransactions.getAllTransactions
);
routers.get(
  "/admin/approve-transaction/:tcode",
  authMiddleware,
  adminManageTransactions.approveTransaction
);
routers.get(
  "/admin/reject-transaction/:tcode",
  authMiddleware,
  adminManageTransactions.rejectTransaction
);

module.exports = routers;
