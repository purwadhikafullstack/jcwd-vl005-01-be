const db = require("../config").promise();

module.exports = {
    getCategory: async (req,res) => {
        try {
            const q = `select * from category`;

            const [category] = await db.execute(q);

            res.status(200).send(category);

        } catch (error) {
            console.log(error.message);
            res.status(500).send("Internal service error");
        }
    },
    getCategoryById: async(req,res) => {
        const id = req.params.id;

        try {
            const q = `select * from category where categoryId=?`
            const [category] = await db.execute(q, [id]);

            if(!category.length){
                res.status(400).send(`Categories with ID ${id} is not found`);
            }
        } catch (error) {
            console.log(error.message);
            res.status(500).send("Internal service error");
        }
    },
    addCategory: async (req,res) => {
        let {categoryName} = req.body;

        try {
            const q = `insert into category(categoryName) values (?)`
            const [category] = await db.execute(q, [categoryName]);
            
            res.status(200).send(category);
        } catch (error) {
            console.log(error.message);
            res.status(500).send("Internal service error")
        }
    },
    deleteCategory: async(req,res) => {
        const id = req.params.id;

        try {
            const q = `delete from category where categoryId=?`
            const [category] = await db.execute(q, [id]);

            res.status(200).send('Sucessfully Deleted!')
        } catch (error) {
            console.log(error.message);
            res.status(500).send("Internal service error");
        }
    },
    updateCategory: async (req,res) => {
        const id = req.params.id;
        const body = req.body;
        
        //query update
        try {
            //if newcategoryName is exist.
            if(body.categoryName){
                const q = `select * from category where categoryName=?`;
                const [category] = await db.execute(q,[body.categoryName]);
                
                if(category.length) {
                    return res.status(400).send("Category Name Already Exist!")
                }
            }
            let dataUpdate = [];
            for(let prop in body){
                dataUpdate.push(`${prop} = '${body[prop]}'`);
            }

            const update = `update category set ${dataUpdate} where categoryId=?`;
            await db.execute(update, [id]);

            res.status(200).send("Data Succesfully Updated")
        } catch (error) {
            console.log(error.message);
            res.status(500).send("Internal service error");
        }
        
    } 
  
}


// export const deleteProduct = (req,res) => {
    
// } 