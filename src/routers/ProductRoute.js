const routers = require("express").Router();

const {product} = require("../controllers");

routers.get('/products', product.getProducts);
routers.get('/products/:id', product.getProductsById);
routers.post('/products', product.saveProduct);
routers.patch('/products/:id', product.updateProducts);
routers.delete('/products/:id', product.deleteProducts);

module.exports = routers;