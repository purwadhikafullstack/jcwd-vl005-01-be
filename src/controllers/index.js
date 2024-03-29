const adminAuth = require("./adminAuth-controller");
const user_controller =  require('./user-controller')
const userTransaction_controller =  require('./user-transaction')
const products_controller =  require('./products-controller')
const product = require("./ProductController");
const category = require("./CategoryController");
const adminManageUser = require("./adminManageUser-cont");
const adminManageTransactions = require("./adminManageTransaction-cont");
const adminGenerateReport = require("./adminGenerateReport-cont");
const cart_controller = require("./cart-controller")
const checkout_controller = require("./checkout-controller")

module.exports = {
  user_controller,
  userTransaction_controller,
  adminAuth,
  products_controller,
  product,
  category,
  adminManageUser,
  adminManageTransactions,
  adminGenerateReport,
  cart_controller,
  checkout_controller
};

