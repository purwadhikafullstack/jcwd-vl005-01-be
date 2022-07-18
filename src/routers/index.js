const adminAuthRouter = require("./adminAuth-router");
const ProductRoute = require("./ProductRoute");
const CategoryRoute = require("./CategoryRoute");
const adminManageUserRouter = require("./adminManageUser-router");
const adminManageTransactionsRouter = require("./adminManageTransaction-router");
const adminGenerateReport = require("./adminGenerateReport-router");

module.exports = {
  adminAuthRouter,
  ProductRoute,
  CategoryRoute,
  adminManageUserRouter,
  adminManageTransactionsRouter,
  adminGenerateReport,
}
