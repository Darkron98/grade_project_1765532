const express = require('express');
const {createAdress, updateAdress, getAddressByUser,deleteAdress} = require('../../controllers/address.controller');
const router = express.Router();

router.post('/create', createAdress);
router.put('/update/:id', updateAdress);
router.get('', getAddressByUser);
router.delete('/delete/:id',deleteAdress);

module.exports = {
    routes: router
}