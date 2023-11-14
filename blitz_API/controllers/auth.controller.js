const firebase = require('../database/connection');
const firestore = firebase.firestore();
const {generateToken}= require('../helpers/jwt');
const bcrypt = require('bcrypt');

const auth = async (req, res) => {
    try{
        const data = req.body;

        if(!data.user_name || !data.password){
            return res.status(400).json(
                {
                    msg: 'missing user credentials'
                }
            );
        }

        const userDoc = await firestore.collection('user').where('user_name', '==', data.user_name).get();
        const userSnapshot = [];
        userDoc.docs.forEach(doc => {
            userSnapshot.push(doc);
        });
        if(!userSnapshot[0].exists){
            return res.status(404).json({
                msg: 'user [' + user_name + '] does not exists' 
            });
        }

        let {password} = userSnapshot[0].data();
        const validatePass = bcrypt.compareSync(data.password, password);
        if(!validatePass){
            return res.status(404).json({
                msg: 'wrong password' 
            });
        }

        const validateUser = userSnapshot[0].data();
        const {user_name, rol} = userSnapshot[0].data();
        const token = await generateToken(validateUser);
        
        res.status(200).json({
            user: {
                user_name: user_name,
                rol: rol,
            },
            token
        });
    }catch(e){
        res.status(400).json({
            msg: 'Authentication error'
        });
    }
}

module.exports = {
    auth
}
