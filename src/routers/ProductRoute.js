const routers = require("express").Router();

const {product} = require("../controllers");

routers.get('/admin/products/details', product.getProductsDetails);
routers.get('/admin/products', product.getProducts);
routers.get('/admin/products/:id', product.getProductsById);
routers.post('/admin/products', product.saveProduct);
routers.post('/admin/products/stock', product.saveProductStock);
routers.patch('/admin/products/:id', product.updateProducts);
routers.delete('/admin/products/:id', product.deleteProducts);
routers.get('/admin/warehouse', product.getWarehouse);
routers.delete('/admin/products/stock/:id', product.deleteStock);
routers.patch('/admin/products/stock/:id', product.editStock);

module.exports = routers;