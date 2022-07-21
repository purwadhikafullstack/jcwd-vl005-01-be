const path = require('path');
const db = require("../config").promise();

module.exports = {
    getProducts: async(req,res) => {
        try {
            const q = `select * from product p join category c on p.categoryId = c.categoryId`;
    
            const [product] = await db.execute(q);
    
            res.status(200).send(product);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }
    },
    getProductsDetails: async(req,res) => {
        try {
            const q = `select s.id, p.img_url,p.name,p.price, p.weight_gram,p.description, c.categoryName, w.name_location, s.stock, s.reserved_stock from product p join category c on p.categoryId = c.categoryId join stock s on s.product_id = p.id join warehouses w on w.id = s.warehouse_id`;
    
            const [product] = await db.execute(q);
    
            res.status(200).send(product);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }
    },
    getProductsById: async(req,res) => {
        const id = req.params.id;
    
        try {
            const q = `select * from product where id=?`;
            const [product] = await db.execute(q, [id]);
            if(!product.length){
                res.status(404).send(`Product with ID ${id} is not found`);
            }
            res.status(200).send(product);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("Internal service error");
        }
    },
    saveProduct : async(req,res) => {
        if(req.files == null){
            return res.status(400).send("No file Uploaded");
        }
        
        let {name, price, weight_gram, description,categoryId} = req.body;
        const file = req.files.file;
        const fileSize = file.data.length;
        const ext = path.extname(file.name);
        const fileName = file.md5 + ext;
        const img_url = `${req.protocol}://${req.get("host")}/images/${fileName}`;
        const allowedType = ['.jpg', '.png', '.jpeg'];

        if(!allowedType.includes(ext.toLocaleLowerCase())) return res.status(422).json({msg:"invalid Images"});
        if(fileSize > 5000000) return res.status(422).send("Image must be less than 5 MB");
        
        file.mv(`./public/images/${fileName}`, async(err) =>{
            if(err) return res.status(500).json({msg: err.message});
            try {
                const q = `insert into product(name,price,weight_gram,description,img_url,categoryId) values(?,?,?,?,?,?)`
                const [product] = await db.execute(q, [
                                name,
                                price,
                                weight_gram,
                                description,
                                img_url,
                                categoryId
                            ])

                            res.status(201).send("Product Created Successfully");

            } catch (error) {
                console.log(error.message);
                res.status(500).send("Internal service error");
            }
        })
    },
    saveProductStock: async(req,res) => {
        let {product_id, warehouse_id, stock , reserved_stock} = req.body;
        try {
            const q2= `insert into stock(product_id,warehouse_id, stock, reserved_stock) values (?,?,?,?)`
            const [stocks] = await db.execute(q2,[product_id, warehouse_id, stock, reserved_stock]);
            res.status(201).send("Successfully added stock!")
            
        } catch (error) {
            console.log(error.message);
            res.status(500).send("Internal service error");
        }   
    },
    deleteProducts: async(req,res) => {
        const id = req.params.id;

        try {
            const q = `delete from product where id=?`
            const [product] = await db.execute(q, [id]);

            res.status(200).send('Sucessfully Deleted!');
        } catch (error) {
            console.log(error.message);
            res.status(500).send("Internal service error");
        }
    },
    updateProducts: async(req,res) => {
        if(req.files == null){
            return res.status(400).send("No file Uploaded");
        }

        const id = req.params.id;
        let {name, price, weight_gram, description,categoryId} = req.body;
        
        //query update
        try {


            //if newcategoryName is exist.
            if(name){
                const q = `select * from product where name=?`;
                const [category] = await db.execute(q,[name]);
                
                if(category.length) {
                    return res.status(400).send("Product Name Already Exist!")
                }
            }

            const file = req.files.file;
            const fileSize = file.data.length;
            const ext = path.extname(file.name);
            const fileName = file.md5 + ext;
            const allowedType = ['.jpg', '.png', '.jpeg'];

            if(!allowedType.includes(ext.toLocaleLowerCase())) return res.status(422).json({msg:"invalid Images"});
            if(fileSize > 5000000) return res.status(422).send("Image must be less than 5 MB");
            
            file.mv(`./public/images/${fileName}`, (err) =>{
                if(err) return res.status(500).json({msg: err.message});
            })

            const img_url = `${req.protocol}://${req.get("host")}/images/${fileName}`;

            const update = `update product set name = ?, price = ?, weight_gram = ?, description=?, img_url=?, categoryId = ? where Id=?`;
            await db.execute(update, [name, price, weight_gram,description, img_url,categoryId, id]);

            res.status(200).send("Data Succesfully Updated")
        } catch (error) {
            console.log(error.message);
            res.status(500).send("Internal service error");
        }
        
    },
    getWarehouse: async(req,res) => {
        try {
            const q = `select * from warehouses`;
    
            const [warehouse] = await db.execute(q);
    
            res.status(200).send(warehouse);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }
    },
    deleteStock: async(req,res) => {
        const id = req.params.id;
        try {
            const q = `delete from stock where id = ? `;
    
            const [warehouse] = await db.execute(q, [id]);
    
            res.status(200).send(warehouse);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }
    },
    editStock: async(req,res) => {
        const id = req.params.id;
        const body = req.body;

        
        try {
            let dataUpdate = [];
            for(let prop in body){
                dataUpdate.push(`${prop} = '${body[prop]}'`);
            }

            const q = `update stock set ${dataUpdate} where id = ? `;
            await db.execute(q, [id]);
    
            res.status(200).send("Data Sucessfully Updated");
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }
    }
}