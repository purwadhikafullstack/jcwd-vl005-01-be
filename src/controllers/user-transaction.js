const database = require('../config').promise()
const puppeteer = require("puppeteer");
// const fs = require("fs-extra");

module.exports.getHistoryTransaction = async (req, res) => {
    const userId = req.params.userId
    try {
        const GET_HISTRANS = `SELECT *, date_format(created_at, '%M %e, %Y') as date 
            FROM transaction_header th
            LEFT JOIN transaction_detail td ON th.id = td.transaction_header_id
            LEFT JOIN product p ON td.product_id = p.id  
            WHERE user_id = ?;` 
        const [ HISTRANS ] = await database.execute(GET_HISTRANS, [userId])
        console.log(HISTRANS)

        return res.status(200).send(HISTRANS)
    } catch (error) {
        console.log('error: ', error)
        return res.status(500).send('Internal Service Error')
    }
}

module.exports.getInvoice = async (req, res) => {
    const tcode = req.params.invoiceN
    try {
        const GET_INVOICE = `SELECT *, date_format(created_at, '%M %e, %Y') as date 
            FROM transaction_header th
            LEFT JOIN transaction_detail td ON th.id = td.transaction_header_id
            LEFT JOIN product p ON td.product_id = p.id  
            WHERE tcode = ?;` 
        const [ INVOICE ] = await database.execute(GET_INVOICE, [tcode])
        console.log(INVOICE)

        return res.status(200).send(INVOICE)
    } catch (error) {
        console.log('error: ', error)
        return res.status(500).send('Internal Service Error')
    }
}

module.exports.saveInvoice = async (req, res) => {
    const tcode = req.params.invoiceN

    try {
        const browser = await puppeteer.launch();
        const page = await browser.newPage();
        // const content = await compile("index", data);
        // console.log(content);
        // await page.setContent("<h1>Hello</h1>");
        // await page.setContent(content);
        // await page.emulateMediaType("screen");
        await page.goto(`${process.env.CLIENT_URL}/invoice/${tcode}`, {waitUntil:"networkidle2"});
        page.setViewport({ width: 1920, height: 1080 })
        const pdf = await page.screenshot({ path: `${tcode}.png` });
        // const pdf = await page.pdf({ 
        //     path: 'mypdf.pdf',
        //     format: "A4",
        //     printBackground: true
        // });
        console.log('done');
        await browser.close();
        // process.exit();
        // return pdf;

        return res.status(200).send(pdf)
    } catch (error) {
        console.log('error: ', error)
        return res.status(500).send('Get PDF Invoice : Internal Service Error')
    }
}
