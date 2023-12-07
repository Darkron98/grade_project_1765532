const {generateToken} = require('../helpers/jwt');
const firebase = require('../database/connection');
const bcrypt = require('bcrypt');
const firestore = firebase.firestore();

const authService = async (data, res) =>{
    try{
        const userDoc = await firestore.collection('user').where('user_name', '==', data.user_name).get();
        const userSnapshot = [];
        
        userDoc.docs.forEach(doc => {
            userSnapshot.push(doc);
        });
        if(userSnapshot.length == 0){
            return res.status(404).json({
                msg: 'user [' + data.user_name + '] does not exists' 
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

module.exports ={
    authService,
}