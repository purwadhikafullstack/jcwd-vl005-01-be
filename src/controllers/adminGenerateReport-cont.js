const database = require("../config").promise();

module.exports.generateReport = async (req, res) => {
  // 1. CAPTURE ALL REQ QUERY PARAMS
  const category = req.query._category;
  const start = req.query._start;
  const end = req.query._end;

  // 2. Do query based on category
  try {
    let GET_DATA;
    if (category === "revenue") {
      GET_DATA = `
        SELECT tcode, created_at, user_id, grand_total, address, postal, province, city 
        FROM transaction_header 
        where created_at between ? and ?; 
        `;
      const [TRANSACTIONS] = await database.execute(GET_DATA, [start, end]);
      let total = 0;
      let temp;
      for (let i = 0; i < TRANSACTIONS.length; i++) {
        total += TRANSACTIONS[i].grand_total;
        temp = TRANSACTIONS[i].created_at.toLocaleDateString();
        TRANSACTIONS[i].created_at = temp;
      }
      return res.json({
        status: 200,
        category: "revenue",
        amount: "Rp." + " " + total,
        transactions: TRANSACTIONS,
      });
    } else if (category === "profit") {
      GET_DATA = `
        SELECT tcode, created_at, user_id, grand_total, address, postal, province, city 
        FROM transaction_header 
        where created_at between ? and ?; 
        `;
      const [TRANSACTIONS] = await database.execute(GET_DATA, [start, end]);
      let total = 0;
      let temp;
      for (let i = 0; i < TRANSACTIONS.length; i++) {
        total += TRANSACTIONS[i].grand_total;
        temp = TRANSACTIONS[i].created_at.toLocaleDateString();
        TRANSACTIONS[i].created_at = temp;
      }
      const profit = total * 0.3;
      return res.json({
        status: 200,
        category: "profit",
        amount: "Rp." + " " + profit,
        transactions: TRANSACTIONS,
      });
    } else if (category === "costs") {
      GET_DATA = `
        SELECT tcode, created_at, user_id, grand_total, address, postal, province, city 
        FROM transaction_header 
        where created_at between ? and ?; 
        `;
      const [TRANSACTIONS] = await database.execute(GET_DATA, [start, end]);

      let temp;
      for (let i = 0; i < TRANSACTIONS.length; i++) {
        temp = TRANSACTIONS[i].created_at.toLocaleDateString();
        TRANSACTIONS[i].created_at = temp;
      }

      const operationalCost = 100000 * TRANSACTIONS.length;
      const fixedCost = 50000 * TRANSACTIONS.length;

      return res.json({
        status: 200,
        category: "Costs",
        amount: "Rp." + " " + operationalCost,
        transactions: TRANSACTIONS,
      });
    } else if (category === "top3") {
      GET_DATA = `
      select sum(td.qty) as total_sold, p.id as product_id, p.name as product_name
      from transaction_detail as td
      join transaction_header as th on td.transaction_header_id = th.id
      join product as p on td.product_id = p.id
      where created_at between ? and ?
      group by p.id
      order by total_sold desc
      limit 3;
      `;
      const [TOP_3_MOST_SOLD] = await database.execute(GET_DATA, [start, end]);
      return res.json({
        status: 200,
        category: "Top 3 Most Sold",
        transactions: TOP_3_MOST_SOLD,
      });
    } else if (category === "numofsales") {
      GET_DATA = `
      SELECT tcode, created_at, user_id, grand_total, address, postal, province, city 
        FROM transaction_header 
        where created_at between ? and ?; 
      `;
      const [NUM_OF_SALES] = await database.execute(GET_DATA, [start, end]);

      let temp;
      for (let i = 0; i < NUM_OF_SALES.length; i++) {
        temp = NUM_OF_SALES[i].created_at.toLocaleDateString();
        NUM_OF_SALES[i].created_at = temp;
      }
      const totalsales = NUM_OF_SALES.length;

      return res.json({
        status: 200,
        category: "Number of Sales",
        amount: totalsales + " " + "Transactions",
        transactions: NUM_OF_SALES,
      });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).send("INTERNAL SERVICE ERROR");
  }
};
