const express = require('express');
const cors = require('cors');
const bodyParser= require('body-parser');
const config = require('./config');

const userRoutes = require('./v1/routes/user.router');
const authRoutes = require('./v1/routes/auth.router');

const app = express();

app.use(express.json());
app.use(cors());
app.use(bodyParser.json());

app.get('', (req,res) => res.send('Me corro! 7w7'));

app.use('/api/v1/user', userRoutes.routes);
app.use('/api/v1/auth', authRoutes.routes);

async function main(){
    try{
        app.listen(
            config.port,
            ()=>console.log("Server running in port "+ config.port)
        );    
    }catch(e){
        throw new Error(e);
    }
}

main();

module.exports = app;