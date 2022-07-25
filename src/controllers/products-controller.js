const database = require('../config').promise()


module.exports.getProducts = async (req, res) => {
    const sort = req.query.sort || 'id' 
    const order = req.query.order || 'ASC'
    // console.log(req.query);

    try {
        const GET_PRODUCTS = `select p.id as id, p.img_url, c.categoryName, c.categoryId, p.description,p.name,p.weight_gram, s.stock, p.price, ct.qty from product p join category c on c.categoryId = p.categoryId left join stock s on s.product_id= p.id left join cart ct on ct.product_id = p.id` 
        const [ PRODUCTS ] = await database.execute(GET_PRODUCTS)

        // console.log(PRODUCTS)

        return res.status(200).send(PRODUCTS)
    } catch (error) {
        console.log('error: ', error)
        return res.status(500).send('Internal Service Error')
    }
}

module.exports.getProductsById = async (req, res) => {
    const productId = req.params.id

    try {
        const GET_PRODUCTS = `select p.id as id, p.img_url, c.categoryName, p.description,p.name,p.weight_gram, s.stock, p.price from product p join category c on c.categoryId = p.categoryId left join stock s on s.product_id= p.id where p.id = ?` 
        const [ PRODUCTS ] = await database.execute(GET_PRODUCTS, [productId])

        console.log(PRODUCTS)

        return res.status(200).send(PRODUCTS)
    } catch (error) {
        console.log('error: ', error)
        return res.status(500).send('Internal Service Error')
    }
}

