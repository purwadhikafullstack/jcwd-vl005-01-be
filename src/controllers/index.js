const adminAuth = require("./adminAuth-controller");
const product = require("./ProductController");
const category = require("./CategoryController");
const adminManageUser = require("./adminManageUser-cont");
const adminManageTransactions = require("./adminManageTransaction-cont");
const adminGenerateReport = require("./adminGenerateReport-cont");

module.exports = {
  adminAuth,
  product,
  category,
  adminManageUser,
  adminManageTransactions,
  adminGenerateReport,
}
