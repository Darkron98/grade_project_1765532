const firebase = require('../database/connection');
const firestore = firebase.firestore();

const createService = async (req, res, user) => {
    const data = req.body;

  try {
    const userQuery = await firestore.collection('user').where('user_name', '==', user).get();
    const user_id = userQuery.docs[0].id;
    const nowDate = new Date();

    const orderCreate = await firestore.collection('order').add({
        address_name: data.address_name,
        lat: data.lat,
        lng: data.lng,
        owner: user,
        owner_id: user_id,
        total_price: data.total_price,
        date: nowDate.toISOString(),
        state: false,
        taken: false,
        delivery_id: "",
        canceled: false
    });

    data.items.forEach(async (e) => await firestore.collection('order').doc(orderCreate.id).collection('items').add({
        item_desc: e.item_desc,
        item_id: e.item_id,
        observations: e.observations,
        quantity: e.quantity,
        unit_price: e.unit_price
      }));

    res.status(200).json({
        msg: "Order created successfuly"
    });
  } catch (error) {
    console.error('Error al crear o añadir dirección:', error);
    res.status(500).json({
      msg: "Internal server error"
    });
  }
}

const takeService = async (req, res, user) => {
  const order_id = req.params.id;

  try {
    const userQuery = await firestore.collection('user').where('user_name', '==', user).get();
    const user_id = userQuery.docs[0].id;
    const updateQuery = await firestore.collection('order').doc(order_id).update({
        taken: true,
        delivery_id: user_id
    });

    res.status(200).json({
      msg: "Order taken successfuly"
    });
  } catch (error) {
    res.status(500).json({
      msg: "Internal server error"
    });
  }
}

const cancelService = async (req, res) => {
  const order_id = req.params.id;
  
    try {
      const updateQuery = await firestore.collection('order').doc(order_id).update({
          canceled: true
      });
  
      res.status(200).json({
        msg: "Order canceled successfuly"
      });
    } catch (error) {
      res.status(500).json({
        msg: "Internal server error"
      });
    }
}

const shippedService = async (req, res) => {
  const order_id = req.params.id;
    try {
      const updateQuery = await firestore.collection('order').doc(order_id).update({
          state: false
      });
  
      res.status(200).json({
        msg: "Order shipped successfuly"
      });
    } catch (error) {
      res.status(500).json({
        msg: "Internal server error"
      });
    }
}

const getService = async (req, res) => {
  try{
    const orderQuery = await firestore.collection('order').where('state', '==', false).get();

    const orderSnapshot = [];

    orderQuery.forEach(doc =>{
      orderSnapshot.push(doc);
    });

    const orderRes = orderSnapshot.map(e => {
      return{
        address_name: e.data.address_name,
        lat: e.data.lat,
        lng: e.data.lng,
        owner: e.data.user,
        owner_id: e.data.user_id,
        total_price: e.data.total_price,
        date: e.data.date,
        state: e.data.state,
        taken: e.data.taken,
        delivery_id: e.data.delivery_id,
        canceled: e.data.canceled,
    };
    });

    res.status(200).json({
        orders: orderRes,
      }
    );
  }catch(e){
    res.status(500).json({
      msg: "Internal server error"
    });
  }
}

module.exports = {
    createService,
    takeService,
    cancelService,
    shippedService,
    getService,
}