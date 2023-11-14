const jwt = require('jsonwebtoken');
require('dotenv').config();

const generateToken = async(usuario) =>{
    const {user_name, rol} = usuario;
    return jwt.sign(
        {
            user_name: user_name,
            rol: rol
        },
        process.env.JWT_SECRET,
        {
            expiresIn: "6h"
        }
    );
}

const verifyToken = async (token)=>{
    try{
        return jwt.verify(token, process.env.JWT_SECRET);
    }catch(e){
        return null;
    }
}

module.exports = {
    generateToken,
    verifyToken
}