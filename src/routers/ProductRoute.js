const routers = require("express").Router();

const {product} = require("../controllers");

routers.get('/admin/products', product.getProducts);
routers.get('/admin//products/:id', product.getProductsById);
routers.post('/admin//products', product.saveProduct);
routers.patch('/admin//products/:id', product.updateProducts);
routers.delete('/admin/products/:id', product.deleteProducts);

module.exports = routers;