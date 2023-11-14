const express = require('express');
const {createUser, getAll, getById, updateUser, deleteUser} = require('../../controllers/user.controller');

const router= express.Router();

router.post('/create',createUser);
router.get('', getAll);
router.get('/:id', getById);
router.put('/:id', updateUser);
router.delete('/:id', deleteUser);

module.exports = {
    routes: router
}