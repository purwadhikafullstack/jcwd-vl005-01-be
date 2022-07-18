const routers = require("express").Router();

const {category} = require("../controllers")

routers.get('/categories', category.getCategory);
routers.get('/categories/:id', category.getCategoryById);
routers.post('/categories', category.addCategory);
routers.delete('/categories/:id', category.deleteCategory);
routers.patch('/categories/:id', category.updateCategory);

module.exports = routers;