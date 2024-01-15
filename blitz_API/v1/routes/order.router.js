const express = require('express');
const {createOrder, takeOrder, cancelOrder, shippedOrder, getAll} = require('../../controllers/order.controller');
const router = express.Router();

router.post('/create', createOrder);
router.put('/take=:id', takeOrder);
router.put('/cancel=:id', cancelOrder);
router.put('/shipped=:id', shippedOrder);
router.get('', getAll);

module.exports = {
    routes: router
}