const express = require('express')
const DB = require('../lib/db')
const router = express.Router()

/**
 * Login View
 */
router.get('/login', (req, res) => {
	req.session.nextUrl = req.originalUrl
	res.render('login', { page_title: 'Login' })
})

/**
 * Login Endpoint
 */
router.post('/login', (req, res) => {
	const credentials = [req.body.email, req.body.password]
	const query = 'SELECT * FROM dorm_wardens WHERE email = ? AND password = ? LIMIT 1;'
	DB.query(query, credentials, (err, rows) => {
		if (err) throw err
		if (rows.length > 0) {
			req.session.loggedIn = true
			res.redirect(req.session.nextUrl)
		} else {
			req.session.loggedIn = false
			res.redirect('/login')
		}
	})
})

/**
 * Logout Endpoint
 */
router.get('/logout', (req, res) => {
	req.session.destroy()
	res.redirect(req.originalUrl)
})
module.exports = router
