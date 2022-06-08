function admin(req, res, next) {
	if (req.session.loggedIn === true) {
		next()
	} else {
		req.session.nextUrl = req.originalUrl
		res.redirect(`/login`)
	}
}

module.exports = admin
