const database = require("../config").promise();

module.exports.generateReport = async (req, res) => {
  // 1. CAPTURE ALL REQ QUERY PARAMS
  const category = req.query._category;
  const start = req.query._start;
  const end = req.query._end;
  // 2. Do Protection, query params must be specified
  if (!category) {
    return res.status(400).send("Please Specify the category");
  } else if (!start) {
    return res.status(400).send("Please Specify the start date period");
  } else if (!end) {
    return res.status(400).send("Please Specify the end date period");
  }
  // 3. Do query based on category
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
      for (let i = 0; i < TRANSACTIONS.length; i++) {
        total += TRANSACTIONS[i].grand_total;
      }
      return res.json({
        status: 200,
        revenue: total,
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
      for (let i = 0; i < TRANSACTIONS.length; i++) {
        total += TRANSACTIONS[i].grand_total;
      }
      const profit = total * 0.3;
      return res.json({
        status: 200,
        profit: profit,
        transactions: TRANSACTIONS,
      });
    } else if (category === "costs") {
      GET_DATA = `
        SELECT tcode, created_at, user_id, grand_total, address, postal, province, city 
        FROM transaction_header 
        where created_at between ? and ?; 
        `;
      const [TRANSACTIONS] = await database.execute(GET_DATA, [start, end]);

      const operationalCost = 100000 * TRANSACTIONS.length;
      const fixedCost = 50000 * TRANSACTIONS.length;

      return res.json({
        status: 200,
        operationalCost,
        fixedCost,
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
        top3MostSold: TOP_3_MOST_SOLD,
      });
    } else if (category === "numofsales") {
      GET_DATA = `
      select th.tcode, th.created_at, p.id as product_id, p.name as product_name, td.qty, th.grand_total
      from transaction_header as th
      join transaction_detail as td on th.id = td.transaction_header_id
      join product as p on td.product_id = p.id
      join user as u on th.user_id = u.user_id
      join user_address as ua on u.user_id = ua.user_id
      where created_at between ? and ?;
      `;
      const [NUM_OF_SALES] = await database.execute(GET_DATA, [start, end]);
      const totalsales = NUM_OF_SALES.length;

      return res.json({
        status: 200,
        totalsales,
        NUM_OF_SALES,
      });
    }
  } catch (error) {
    console.log(error);
    return res.status(500).send("INTERNAL SERVICE ERROR");
  }
};
