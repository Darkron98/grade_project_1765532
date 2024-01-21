const express = require('express');
const {createOrder, takeOrder, cancelOrder, shippedOrder, getAll, updateOrderItem, deleteOrderItem, addOrderItem} = require('../../controllers/order.controller');
const router = express.Router();


router.post('/create', createOrder);
router.patch('/take=:id', takeOrder);
router.delete('/cancel=:id', cancelOrder);
router.patch('/shipped=:id', shippedOrder);
router.patch('/updateitem=:orderId;:itemId', updateOrderItem);
router.delete('/deleteitem=:orderId;:itemId', deleteOrderItem);
router.get('', getAll);
router.post('/item.add=:id', addOrderItem);

module.exports = {
    routes: router
}