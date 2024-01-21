
const bodyParser = require('body-parser');
const express = require('express');
const config = require('./config');
const cors = require('cors');

const employeeRoutes = require('./v1/routes/employee.router');
const userRoutes = require('./v1/routes/user.router');
const authRoutes = require('./v1/routes/auth.router');
const addressRoutes = require('./v1/routes/address.router');
const menuRoutes = require('./v1/routes/menu.router');
const orderRoutes = require('./v1/routes/order.router');
const swaggerDocs = require('./documentation/swagger');

//#region app config
const app = express();

app.use(express.json());
app.use(cors());
app.use(bodyParser.json());

app.get('', (req,res) => res.status(200).json({
        msg: "Server running in port "+ config.port
    })
);

app.use('/api/v1/user', userRoutes.routes);
app.use('/api/v1/auth', authRoutes.routes);
app.use('/api/v1/employee', employeeRoutes.routes);
app.use('/api/v1/address', addressRoutes.routes);
app.use('/api/v1/menu', menuRoutes.routes);
app.use('/api/v1/order', orderRoutes.routes);
//#endregion

//#region startup
async function main(){
    try{
        app.listen(
            config.port,
            () => console.log("Server running in port "+ config.port)
        ); 
        swaggerDocs.swaggerDocs(app, config.port);   
    }catch(e){
        throw new Error(e);
    }
}

main();
//#endregion

module.exports = app;