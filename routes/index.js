const express = require('express')
const router = express.Router()

/**
 * Index Route
 */
router.get('/', (req, res) => {
	res.render('index', { page_title: 'Home' })
})

module.exports = router
