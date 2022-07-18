const adminAuth = require("./adminAuth-controller");
const user_controller =  require('./user-controller')
const products_controller =  require('./products-controller')

module.exports = {
  user_controller,
  adminAuth,
  products_controller,
};
