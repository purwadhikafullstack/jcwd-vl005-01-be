const user_router = require("./user-routers")
const userTransaction_router = require("./userTransaction-routers")
const adminAuthRouter = require("./adminAuth-router");
const products_routers = require("./products-routers")
const ProductRoute = require("./ProductRoute");
const CategoryRoute = require("./CategoryRoute");
const adminManageUserRouter = require("./adminManageUser-router");
const adminManageTransactionsRouter = require("./adminManageTransaction-router");
const adminGenerateReport = require("./adminGenerateReport-router");
const cart_router = require("./cart-routers");
const checkout_router = require("./checkout-router");

module.exports = {
  user_router,
  userTransaction_router,
  adminAuthRouter,
  products_routers,
  ProductRoute,
  CategoryRoute,
  adminManageUserRouter,
  adminManageTransactionsRouter,
  adminGenerateReport,
  cart_router,
  checkout_router
};

