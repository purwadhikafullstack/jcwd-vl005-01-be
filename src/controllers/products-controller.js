const database = require('../config').promise()


module.exports.getProducts = async (req, res) => {
    // const sort = req.query.sort || 'product_id' 
    // const order = req.query.order || 'ASC'
    // console.log(req.query);

    try {
        const GET_PRODUCTS = `select * from product p join category c on p.categoryId = c.categoryId` 
        const [ PRODUCTS ] = await database.execute(GET_PRODUCTS)

        console.log(PRODUCTS)

        return res.status(200).send(PRODUCTS)
    } catch (error) {
        console.log('error: ', error)
        return res.status(500).send('Internal Service Error')
    }
}

module.exports.getProductsById = async (req, res) => {
    const productId = req.params.id

    try {
        const GET_PRODUCTS = `select * from product p join category c on p.categoryId = c.categoryId WHERE id = ?` 
        const [ PRODUCTS ] = await database.execute(GET_PRODUCTS, [productId])

        console.log(PRODUCTS)

        return res.status(200).send(PRODUCTS)
    } catch (error) {
        console.log('error: ', error)
        return res.status(500).send('Internal Service Error')
    }
}
