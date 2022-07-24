const routers = require("express").Router();

const { userTransaction_controller } = require('../controllers')

routers.get('/invoice/:userId', userTransaction_controller.getHistoryTransaction)
routers.get('/printinvoice/:invoiceN', userTransaction_controller.getInvoice)
routers.get('/downloadinvoice/:invoiceN', userTransaction_controller.saveInvoice)

module.exports = routers;