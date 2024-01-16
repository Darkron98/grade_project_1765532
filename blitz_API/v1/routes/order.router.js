const express = require('express');
const {createOrder, takeOrder, cancelOrder, shippedOrder, getAll, updateOrderItem} = require('../../controllers/order.controller');
const router = express.Router();

router.post('/create', createOrder);
router.patch('/take=:id', takeOrder);
router.delete('/cancel=:id', cancelOrder);
router.patch('/shipped=:id', shippedOrder);
router.patch('/updateitem=:orderId;:itemId', updateOrderItem);
router.get('', getAll);

module.exports = {
    routes: router
}