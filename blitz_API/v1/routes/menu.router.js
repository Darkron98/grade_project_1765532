const controller = require('../../controllers/menu.controller');
const express = require('express');
const router = express.Router();

router.post('/create', controller.createDish);
router.get('', controller.getDish);
router.put('/update=:id', controller.updateDish);
router.delete('/delete=:id', controller.deleteDish);

module.exports = {
    routes: router,
}