const adminAuthRouter = require("./adminAuth-router");
const adminManageUserRouter = require("./adminManageUser-router");
const adminManageTransactionsRouter = require("./adminManageTransaction-router");
const adminGenerateReport = require("./adminGenerateReport-router");

module.exports = {
  adminAuthRouter,
  adminManageUserRouter,
  adminManageTransactionsRouter,
  adminGenerateReport,
};
