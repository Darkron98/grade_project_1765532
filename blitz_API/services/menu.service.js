const firebase = require('../database/connection');
const firestore = firebase.firestore();

const createService = async (req, res) => {
    const data = req.body;
    try{
        const {
            category_id, 
            description, 
            dish_name, 
            label_img, 
            price
        } = data;

        const connection = await firestore.collection('menu').add({
            category_id: category_id,
            description: description,
            dish_name: dish_name,
            label_img: label_img,
            price: price,
        });
        res.status(200).json({
            msg: 'menu item added successfully'    
        });
    }catch(e){
        res.status(500).json({
            msg: "Internal server error"
        });
    }
}

const getService = async (req, res) => {
    try{
        const dishes = await firestore.collection('menu');
        const data =  await dishes.get();
        const dishesList = [];
        if(data.empty){
            res.status(404).json({
                msg: 'no data'
            });
        }else{
            data.docs.forEach(doc => {
                    const dish = {
                        category_id: doc.data().category_id,
                        description: doc.data().description,
                        dish_name: doc.data().dish_name,
                        label_img: doc.data().label_img,
                        price: doc.data().price
                    }
                    dishesList.push(dish);
                }
            );
            res.status(200).json({
                msg: 'OK',
                data: dishesList
            });
        }
    }catch (e){
        res.status(500).json({
            msg: "Internal server error"
        });
    }
}

const updateService = async (req, res) => {
  const data = req.body;
  const item_id = req.params.id;

  try {
    const addressQuery = await firestore.collection('menu').doc(item_id).update(data);

    res.status(200).json({
      msg: "item updated successfuly"
    });
  } catch (error) {
    res.status(500).json({
      msg: "Internal server error"
    });
  }
}

const deleteService = async (req, res) => {
    const item_id = req.params.id;
    try {
      const addressQuery = await firestore.collection('menu').doc(item_id).delete();
  
      res.status(200).json({
        msg: "item deleted successfuly"
      });
    } catch (error) {
      res.status(500).json({
        msg: "Internal server error"
      });
    }
  }

module.exports = {
    createService,
    getService,
    updateService,
    deleteService,
}