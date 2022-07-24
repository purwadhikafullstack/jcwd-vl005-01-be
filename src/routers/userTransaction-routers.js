const routers = require("express").Router();

const { userTransaction_controller } = require('../controllers')

routers.get('/invoice/:userId', userTransaction_controller.getHistoryTransaction)
routers.get('/user/test', userTransaction_controller.testPuppeter)

module.exports = routers;