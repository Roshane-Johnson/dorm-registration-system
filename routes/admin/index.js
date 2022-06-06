const express = require('express')
const router = express.Router()
const DB = require('../../lib/db')

/**
 * Admin Index Route
 */
router.get('/', (req, res) => {
	res.render('admin/index', { page_title: 'Dashboard', layout: 'layouts/admin' })
})

module.exports = router
