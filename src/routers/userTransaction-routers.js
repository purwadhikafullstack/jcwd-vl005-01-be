const routers = require("express").Router();

const { userTransaction_controller } = require('../controllers')

routers.get('/user/historytransaction', userTransaction_controller.getHistoryTransaction)

module.exports = routers;