const routers = require("express").Router();

const {checkout_controller} = require("../controllers")

routers.get('/checkout/address/:id', checkout_controller.getUserAddress);
routers.post('/checkout/address', checkout_controller.addUserAddress);
routers.patch('checkout/address/:id', checkout_controller.updateUserAddress);
routers.post('/checkout/products', checkout_controller.AddTransaction);
routers.get('/user/checkout/address/:id', checkout_controller.getUserAddressById);



module.exports = routers;