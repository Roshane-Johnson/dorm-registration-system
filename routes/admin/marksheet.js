const express = require('express')
const router = express.Router()
const DB = require('../../lib/db')
const { SuccessResponse, ErrorResponse } = require('../../lib/helpers')

// TODO Create marksheet feature
// TODO Add photo upload for trainee

/**
 * All Marksheet View
 */
router.get('/', (req, res) => {
	const query = 'SELECT * FROM mark_statuses LIMIT 10000;'

	DB.query(query, (err, statuses) => {
		if (err) throw err

		const query = `SELECT 
                        trn.id AS trn_id,
                        mks.id AS mks_id,
                        trn.first_nm,
                        trn.last_nm,
                        mkst.status,
                        trn.email,
                        trn.phone_num,
                        gnd.gender,
                        crs.name AS course,
                        drm.name AS dorm_room,
                        trn.uuid,
                        mks.date,
                        mks.created_at,
                        mks.updated_at
                    FROM marksheet mks
                    LEFT JOIN trainees trn ON trn.id = mks.trainee_id
                    LEFT JOIN dorm_wardens drw ON drw.id = mks.dorm_warden_id
                    LEFT JOIN mark_statuses mkst ON mkst.id = mks.mark_status_id
                    LEFT JOIN genders gnd ON trn.gender_id = gnd.id
                    LEFT JOIN dorm_rooms drm ON trn.doorm_room_id = drm.id
                    LEFT JOIN courses crs ON trn.course_id = crs.id
                    WHERE mks.date = ? LIMIT 10000;`
		const todayAsDate = new Date().toISOString().replace('T', ' ').split(' ')[0]
		const _todayAsDate = new Date().toUTCString().split(' ').slice(0, 4).join(' ')
		DB.query(query, todayAsDate, (err, rows) => {
			if (err) throw err
			res.render('admin/marksheet/index', { page_title: 'All Trainees', layout: 'layouts/admin', trainees: rows, todayAsDate: _todayAsDate, statuses })
		})
	})
})

/**
 * Marksheet check specific date history view
 */
router.get('/history', (req, res) => {
	res.render('admin/marksheet/check_history', { page_title: 'Marksheet History Check', layout: 'layouts/admin' })
})

/**
 * Marksheet specific date history endpoint
 */
router.post('/history', (req, res) => {
	const query = `SELECT 
                        trn.id AS trn_id,
                        mks.id AS mks_id,
                        trn.first_nm,
                        trn.last_nm,
                        mkst.status,
                        trn.email,
                        gnd.gender,
                        trn.phone_num,
                        crs.name AS course,
                        trn.uuid,
                        mks.date,
                        mks.created_at,
                        mks.updated_at
                    FROM marksheet mks
                    LEFT JOIN trainees trn ON trn.id = mks.trainee_id
                    LEFT JOIN dorm_wardens drw ON drw.id = mks.dorm_warden_id
                    LEFT JOIN mark_statuses mkst ON mkst.id = mks.mark_status_id
                    LEFT JOIN genders gnd ON trn.gender_id = gnd.id
                    LEFT JOIN dorm_rooms drm ON trn.doorm_room_id = drm.id
                    LEFT JOIN courses crs ON trn.course_id = crs.id
                    WHERE mks.date = ? LIMIT 10000;`
	const checkDate = new Date(req.body.date).toUTCString().split(' ').slice(0, 4).join(' ')
	const _checkDate = req.body.date
	DB.query(query, _checkDate, (err, rows) => {
		if (err) throw err
		res.render('admin/marksheet/history', { page_title: `Marksheet for (${checkDate})`, layout: 'layouts/admin', trainees: rows, checkDate })
	})
})

/**
 * Marksheet setup for current day register endpoint
 */
router.get('/setup', (req, res) => {
	// Test Code
	req.session.dorm_warden_id = 1

	const query = `INSERT INTO marksheet (date, trainee_id, dorm_warden_id, mark_status_id)
                    SELECT CURRENT_DATE, id, ?, 2 FROM trainees LIMIT 10000;`
	DB.query(query, req.session.dorm_warden_id, (err, results) => {
		if (err) throw err

		res.redirect('/admin/marksheet')
	})
})

/**
 * Marksheet status update endpoint
 */
router.post('/status/:id', (req, res) => {
	const marksheet_id = req.params.id
	const data = {
		mark_status_id: req.body.trn_status,
	}

	const query = 'UPDATE marksheet SET ? WHERE id = ?;'

	DB.query(query, [data, marksheet_id], (err, results) => {
		if (err) throw err

		res.redirect('/admin/marksheet')
	})
})

module.exports = router
