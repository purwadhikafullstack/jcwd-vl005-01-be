const routers = require("express").Router();

const { products_controller } = require('../controllers')

// define route
routers.get('/products', products_controller.getProducts)

module.exports = routers;