const database = require('../config').promise()
const puppeteer = require("puppeteer");

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

module.exports.testPuppeter = async (req, res) => {
    const browser = await puppeteer.launch()
    const page = await browser.newPage()

    try {
        const htmlContent = `<body>
        <h1>An example static HTML to PDF</h1>
        </body>`
        await page.setContent(htmlContent)
        await page.pdf({ path: 'html.pdf', format: 'A4' })

        await browser.close()
    } catch (error) {
        console.log('error: ', error)
        return res.status(500).send('Internal Service Error')
    }
    
    async function createPDF(data){

        var templateHtml = fs.readFileSync(path.join(process.cwd(), 'template.html'), 'utf8');
        var template = handlebars.compile(templateHtml);
        var html = template(data);

        var milis = new Date();
        milis = milis.getTime();

        var pdfPath = path.join('pdf', `${data.name}-${milis}.pdf`);

        var options = {
            width: '1230px',
            headerTemplate: "<p></p>",
            footerTemplate: "<p></p>",
            displayHeaderFooter: false,
            margin: {
                top: "10px",
                bottom: "30px"
            },
            printBackground: true,
            path: pdfPath
        }

        const browser = await puppeteer.launch({
            args: ['--no-sandbox'],
            headless: true
        });

        var page = await browser.newPage();
        
        await page.goto(`data:text/html;charset=UTF-8,${html}`, {
            waitUntil: 'networkidle0'
        });

        await page.pdf(options);
        await browser.close();
    }
}
