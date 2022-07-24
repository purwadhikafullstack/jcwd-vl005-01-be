const db = require("../config").promise();

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
    addUserAddress: async(req,res) => {
        const {user_id, address, postal,city, province, label, lat, long} = req.body;
        try {
            if(address) {
                const searchQ = `select * from user_address where address = ?  AND label = ?`
                const [search] = await db.execute(searchQ, [address,label]);
                if(search.length){
                    res.status(400).send("Address or Label Already Exist");
                }
            }
            const q = `insert into user_address(user_id, address, postal, city, province, label, lat, long) values(?,?,?,?,?,?,?,?)`;
    
            const [address] = await db.execute(q, [user_id, address ,postal, city, province, label, lat, long]);
    
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

    }
}