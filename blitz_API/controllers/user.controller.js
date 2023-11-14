const firebase = require('../database/connection');
const User = require('../database/models/user.model');
const firestore = firebase.firestore();

const createUser = async (req, res, next) => {
    try{
        const data = req.body;
        const userDoc = await firestore.collection('user').doc(data.user_name);
        const userSnapshot = await userDoc.get();

        if(userSnapshot.exists){
            res.status(400).json({
                msg: 'user already exists' 
            });
        } else {
            const {first_name, last_name, mail, phone, second_name} = data;
            const {password, rol, user_name} = data;
            const user = await firestore.collection('user').add({
                password, 
                rol, 
                user_name
            });
            
            const user_id = user.id;
            const userData = await firestore.collection('user_data').add({
                first_name, 
                last_name, 
                mail, phone, 
                second_name,
                user_id
            });
                
            res.status(200).json({
                msg: 'register successfuly'    
            });
        }
    }  
    catch(e){
        res.status(400).json({
            msg: 'register error',
            error: e
        });
    }
}

const getAll = async (req, res, next) => {
    try{
        const users = await firestore.collection('user');
        const data =  await users.get();
        const userList = [];
        if(data.empty){
            res.status(404).json({
                msg: 'no data'
            });
        }else{
            data.docs.forEach(doc => {
                const user = new User(
                    doc.data().rol,
                    doc.data().user_name
                    );
                    userList.push(user);
            });
            res.status(200).json({
                msg: 'OK',
                user_list: userList
            });
        }
    }catch(e){
        res.status(400).json({
            msg: 'bad request',
            error: e
        });
    }
}

const getById = async (req, res, next) => {
    try{
        const id = req.params.id;
        const user = await firestore.collection('user').doc(id);
        const userSnapshot = await user.get();

        const user_id = userSnapshot.id;

        const userDataQuery= await firestore.collection('user_data').where('user_id', '==', user_id).get();
        const userDataSnapshot = [];
        userDataQuery.forEach(doc => {
            userDataSnapshot.push(doc);
        });

        if(!userSnapshot.exists){
            res.status(404).json({
                msg: 'user with ID:' + id +' dont exists'
            });
        }else{
            const {rol, user_name} = userSnapshot.data();
            const userResp = new User(
                rol, 
                user_name
            );
            res.status(200).json({
                msg: 'OK',
                user: userResp,
                user_data: userDataSnapshot[0].data()
            })
        }
    }catch(e){
        res.status(400).json({
            msg: 'bad request',
            error: e
        })
    }
}

const updateUser = async (req, res, next) => {
    try{
        const id = req.params.id;
        const data = req.body;
        const user = await firestore.collection('user').doc(id);
        await user.update(data);

        res.status(200).json({
            msg: 'user updated' 
        });
    }catch(e){
        res.status(400).json({
            msg: 'bad request',
            error: e
        });
    }
}

const deleteUser = async (req, res, next) =>{
    try{
        const id = req.params.id;
        const data= req.body;
        const user = await firestore.collection('user').doc(id).delete();

        res.status(200).json({
            msg: 'user deleted' 
        });
    }catch(e){
        res.status(400).json({
            msg: 'bad request',
            error: e
        });
    }
}

module.exports = {
    createUser,
    getAll,
    getById,
    updateUser,
    deleteUser
}