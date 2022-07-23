const database = require('../config').promise()

module.exports.getHistoryTransaction = async (req, res) => {
    const {user_id} = req.body
    try {
        const GET_HISTRANS = `SELECT * FROM transaction_header WHERE user_id = ?;` 
        const [ HISTRANS ] = await database.execute(GET_PRODUCTS, [user_id])

        console.log(HISTRANS)

        return res.status(200).send(HISTRANS)
    } catch (error) {
        console.log('error: ', error)
        return res.status(500).send('Internal Service Error')
    }
}

