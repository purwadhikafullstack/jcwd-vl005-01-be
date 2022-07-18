const routers = require("express").Router();

const { adminGenerateReport } = require("../controllers");
const authMiddleware = require("../helpers/adminAuthMiddleware");

routers.get(
  "/admin/report",
  authMiddleware,
  adminGenerateReport.generateReport
);

module.exports = routers;
