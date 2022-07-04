const database = require("../config").promise();

// GET ALL TRANSACTIONS
module.exports.getAllTransactions = async (req, res) => {
  try {
    // Get all transactions
    const GET_TRANSACTIONS = `
    select th.tcode, th.created_at, u.user_id, p.id as product_id, p.name as product_name, td.qty, th.grand_total, th.status, ua.address
    from transaction_header as th
    join transaction_detail as td on th.id = td.transaction_header_id
    join product as p on td.product_id = p.id
    join user as u on th.user_id = u.user_id
    join user_address as ua on u.user_id = ua.user_id;
    `;
    const [TRANSACTIONS] = await database.execute(GET_TRANSACTIONS);
    // Send response
    return res.status(200).send(TRANSACTIONS);
  } catch (error) {
    return res.status(500).send("INTERNAL SERVICE ERROR");
  }
};

//  APPROVE TRANSACTIONS
module.exports.approveTransaction = async (req, res) => {
  const tcode = req.params.tcode;

  try {
    // Change Transaction Status
    const APPROVE_TRANSACTION = `update transaction_header set status = 'Approved' where tcode = ?`;
    await database.execute(APPROVE_TRANSACTION, [tcode]);
    // Send Respond to Client
    res.status(200).send("Transaction has been approved");
  } catch (error) {
    return res.status(500).send("Internal Service Error");
  }
};

//  REJECT TRANSACTIONS
module.exports.rejectTransaction = async (req, res) => {
  const tcode = req.params.tcode;

  try {
    // Change Transaction Status
    const REJECT_TRANSACTION = `update transaction_header set status = 'Rejected' where tcode = ?`;
    await database.execute(REJECT_TRANSACTION, [tcode]);
    // Send Respond to Client
    res.status(200).send("Transaction has been Rejected");
  } catch (error) {
    return res.status(500).send("Internal Service Error");
  }
};
