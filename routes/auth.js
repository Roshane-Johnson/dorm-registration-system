const express = require('express')
const DB = require('../lib/db')
const router = express.Router()
const bcrypt = require('bcrypt')
/**
 * Login View
 */
router.get('/login', (req, res) => {
	res.render('login', { page_title: 'Login' })
})

/**
 * Login Endpoint
 */
router.post('/login', (req, res) => {
	const [email, password] = [req.body.email, req.body.password]
	const query = 'SELECT * FROM dorm_wardens WHERE email = ? LIMIT 1;'
	DB.query(query, [email, password], (err, rows) => {
		if (err) throw err
		if (bcrypt.compareSync(password, rows[0].password) && rows.length > 0) {
			req.session.loggedIn = true
			req.session.dorm_warden_id = rows[0].id
			res.redirect(req.session.nextUrl)
		} else {
			req.session.destroy()
			res.redirect(`/login`)
		}
	})
})

/**
 * Logout Endpoint
 */
router.get('/logout', (req, res) => {
	req.session.destroy()
	res.redirect('/')
})

/**
 * B-Crypt Password Generator
 */
router.get('/bcrypt/:password', (req, res) => {
	const hashedPassword = bcrypt.hashSync(req.params.password, 10)
	res.json({ message: { plain: req.params.password, hashed: hashedPassword } })
})
module.exports = router
