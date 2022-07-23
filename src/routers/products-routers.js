const routers = require("express").Router();

const { products_controller } = require('../controllers')

// define route
routers.get('/products', products_controller.getProducts)
routers.get('/products/:id', products_controller.getProductsById)

module.exports = routers;