const routers = require("express").Router();

const {category} = require("../controllers")

routers.get('/admin/categories', category.getCategory);
routers.get('/admin/categories/:id', category.getCategoryById);
routers.post('/admin/categories', category.addCategory);
routers.delete('/admin/categories/:id', category.deleteCategory);
routers.patch('/admin/categories/:id', category.updateCategory);

module.exports = routers;