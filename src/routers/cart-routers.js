const routers = require("express").Router();

const {cart_controller} = require("../controllers");

routers.get('/cart/products', cart_controller.getCartProduct);
routers.delete('/cart/products/:id', cart_controller.deleteCartProduct);
routers.get('/cart/total', cart_controller.getSumCartProduct);
routers.post('/cart/products', cart_controller.addCartProduct);
routers.patch('/cart/products/:id', cart_controller.updateCartProduct);

module.exports = routers;