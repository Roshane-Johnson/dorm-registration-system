const express = require('express')
const router = express.Router()
const DB = require('../../lib/db')

/**
 * Admin Index Route
 */
router.get('/', (req, res) => {
	const query = `SELECT COUNT(id) AS trainee_count FROM trainees;
					SELECT COUNT(id) AS dorm_warden_count FROM dorm_wardens;`
	DB.query(query, (err, rows) => {
		if (err) throw err

		const _rows = rows.flat()
		const totals = {
			trainee_count: _rows[0].trainee_count,
			dorm_warden_count: _rows[1].dorm_warden_count,
		}

		res.render('admin/index', { page_title: 'Dashboard', layout: 'layouts/admin', totals })
	})
})

module.exports = router
