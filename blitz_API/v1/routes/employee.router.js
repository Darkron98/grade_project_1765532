const express = require('express');
const {createEmployee, getAll, getByIdDoc, fireEmployee, updateEmployee} = require('../../controllers/employee.controller');
const router = express.Router();

router.post('/create', createEmployee);
router.get('', getAll);
router.get('/:id', getByIdDoc);
router.patch('/dismiss/:id', fireEmployee);
router.put('/:id', updateEmployee);

module.exports = {
    routes: router
}