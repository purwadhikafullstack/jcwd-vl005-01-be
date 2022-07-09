const adminAuth = require("./adminAuth-controller");
const adminManageUser = require("./adminManageUser-cont");
const adminManageTransactions = require("./adminManageTransaction-cont");
const adminGenerateReport = require("./adminGenerateReport-cont");

module.exports = {
  adminAuth,
  adminManageUser,
  adminManageTransactions,
  adminGenerateReport,
};
