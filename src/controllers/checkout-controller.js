const db = require("../config").promise();
const path = require('path');

module.exports = {
    getUserAddress: async(req,res) => {
        const user_id = req.params.id;
        try {
            const q = `select * from user_address where user_id=?`;
    
            const [address] = await db.execute(q, [user_id]);
    
            res.status(200).send(address);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }
    },
    getUserAddressById : async(req,res) => {
        const id = req.params.id;

        try {
            const q = `select * from user_address where id=?`;
    
            const [address] = await db.execute(q, [id]);
    
            res.status(200).send(address);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }

    },
    addUserAddress: async(req,res) => {
        const {user_id, user_address, postal,city, province, label, lat, long} = req.body;
        try {
            if(user_address) {
                const searchQ = `select * from user_address where address = ?  AND label = ?`
                const [search] = await db.execute(searchQ, [user_address,label]);
                if(search.length){
                    res.status(400).send("Address or Label Already Exist");
                }
            }
            const q = `insert into user_address(user_id, address, postal, city, province, label, latitude, longitude) values (?,?,?,?,?,?,?,?)`;
    
            const [address] = await db.execute(q, [user_id, user_address ,postal, city, province, label, lat, long]);

            res.status(200).send(address);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }
    },
    updateUserAddress: async(req,res) => {
        const id = req.params.id;
        const {} = req.body;
        try {
            if(address) {
                const searchQ = `select * from user_address where address = ?  AND label = ?`
                const [search] = await db.execute(searchQ, [address,label]);
                if(search.length){
                    res.status(400).send("Address or Label Already Exist");
                }
            }

            let dataUpdate = [];
            for(let prop in body){
                dataUpdate.push(`${prop} = '${body[prop]}'`);
            }
            const q = `update user_address set ${dataUpdate} where id=?`;
    
            const [address] = await db.execute(q, [id]);
    
            res.status(200).send(address);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }
    },
    AddTransaction: async(req,res) => {
        if(req.files == null){
            return res.status(400).send("No file Uploaded");
        }

        const {
            tcode, 
            warehouse_id, 
            user_id, 
            grand_total,
            address,
            city,
            postal,
            province,
            lat,
            long
        } = req.body;

        try {
            
            const q = `insert into transaction_header(tcode, shipping_warehouse_id, user_id, grand_total, address, city, postal, province, latitude, longitude) values (?,?,?,?,?,?,?,?,?,?)`;
            await db.execute(q, [tcode,warehouse_id,user_id, grand_total,address , city, postal, province, lat, long]);

            const qSearch = `select * from transaction_header where tcode=?`
            const [transaction] = await db.execute(qSearch, [tcode]);

            const file = req.files.file;
            const fileSize = file.data.length;
            const ext = path.extname(file.name);
            const fileName = file.md5 + ext;
            const img_url = `${req.protocol}://${req.get("host")}/images/${fileName}`;
            const allowedType = ['.jpg', '.png', '.jpeg'];
    
            if(!allowedType.includes(ext.toLocaleLowerCase())) return res.status(422).json({msg:"invalid Images"});
            if(fileSize > 5000000) return res.status(422).send("Image must be less than 5 MB");
    
            file.mv(`./public/images/${fileName}`, async(err) => {
                if (err) return res.status(500).json({msg: err.message});
                    const q = `insert into payment_verif(transaction_header_id, img_url) values (?,?)`;
            
                   await db.execute(q, [transaction[0].id, img_url]);
            })

            const q2=`select SUM(c.qty*p.price) as sum, p.name, p.price, p.img_url, p.categoryId, c.qty, c.product_id , c.id, c.user_id, s.stock, s.warehouse_id from cart c join product p on p.id = c.product_id  join stock s on s.product_id = c.product_id where c.user_id = ? GROUP BY  p.name, p.price, p.img_url, p.categoryId, c.qty, c.product_id , c.id, c.user_id`
            const [cart] = await db.execute(q2, [user_id]);            
            

            cart.map((item,index) => {
                const q3 = `insert into transaction_detail(transaction_header_id, product_id, qty, price) values (?,?,?,?)`;
        
                db.execute(q3, [transaction[0].id, item.product_id, item.qty, item.price]);

                const q4 = `delete from cart where user_id=?`
                db.execute(q4, [user_id])
            })

            
            res.status(200).send("Successfuly Added!");
        } catch (error) {
            console.log(error.message);
            res.status(500).send("internal service error");
        }

    }
}