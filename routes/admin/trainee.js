const express = require('express')
const router = express.Router()
const DB = require('../../lib/db')

/**
 * All Trainees View
 */
router.get('/', (req, res) => {
	const query = `SELECT 
						trn.id,
						trn.first_nm,
						trn.last_nm,
						trn.dob,
						trn.email,
						crs.name AS course,
						trn.phone_num,
						gnd.gender,
						drm.name AS dorm_room,
						trn.uuid,
						trn.created_at,
						trn.updated_at
					FROM trainees trn
					LEFT JOIN genders gnd ON trn.gender_id = gnd.id
					LEFT JOIN dorm_rooms drm ON trn.doorm_room_id = drm.id 
					LEFT JOIN courses crs ON trn.course_id = crs.id
					LIMIT 10000;`
	DB.query(query, (err, rows) => {
		if (err) {
			throw err
		}

		res.render('admin/trainee/index', { page_title: 'All Trainees', layout: 'layouts/admin', trainees: rows })
	})
})

/**
 * Trainee Add View
 */
router.get('/add', (req, res) => {
	const query = 'SELECT * FROM genders LIMIT 10000;'
	DB.query(query, (err, genders) => {
		if (err) throw err

		const query = 'SELECT * FROM dorm_rooms LIMIT 10000;'
		DB.query(query, (err, dorm_rooms) => {
			res.render('admin/trainee/add', { page_title: 'Add Trainee', layout: 'layouts/admin', genders, dorm_rooms })
		})
	})
})

/**
 * Trainee Edit View
 */
router.get('/edit/:uuid', (req, res) => {
	const query = 'SELECT * FROM genders LIMIT 10000;'
	DB.query(query, (err, genders) => {
		if (err) throw err

		const query = 'SELECT * FROM dorm_rooms LIMIT 10000;'
		DB.query(query, (err, dorm_rooms) => {
			if (err) throw err

			const query = `SELECT 
								trn.id,
								trn.first_nm,
								trn.last_nm,
								trn.dob,
								trn.phone_num,
								trn.email,
								gnd.id AS gender_id,
								drm.id AS dorm_room_id,
								trn.uuid,
								trn.created_at,
								trn.updated_at
							FROM trainees trn
							JOIN genders gnd ON trn.gender_id = gnd.id
							JOIN dorm_rooms drm ON trn.doorm_room_id = drm.id WHERE uuid = ?;`
			DB.query(query, req.params.uuid, (err, rows) => {
				if (err) throw err

				res.render('admin/trainee/edit', { page_title: 'Edit Trainee', layout: 'layouts/admin', trainee: rows[0], genders, dorm_rooms })
			})
		})
	})
})

/**
 * Trainee Add Endpoint
 */
router.post('/add', (req, res) => {
	let insertData = {
		first_nm: req.body.f_name.trim(),
		last_nm: req.body.l_name.trim(),
		email: req.body.email.trim(),
		dob: req.body.dob.trim(),
		phone_num: req.body.p_num.trim(),
		gender_id: req.body.gndr_id.trim(),
		doorm_room_id: req.body.drm_id.trim(),
	}

	const query = 'INSERT INTO trainees SET ?;'
	DB.query(query, insertData, (err, results) => {
		if (err) throw err

		res.redirect('/admin/trainees')
	})
})

/**
 * Trainee Update Endpoint
 */
router.post('/update/:uuid', (req, res) => {
	let insertData = {
		first_nm: req.body.f_name.trim(),
		last_nm: req.body.l_name.trim(),
		email: req.body.email.trim(),
		dob: req.body.dob.trim(),
		phone_num: req.body.p_num.trim(),
		gender_id: req.body.gndr_id.trim(),
		doorm_room_id: req.body.drm_id.trim(),
	}

	const query = 'UPDATE trainees SET ? WHERE uuid = ?;'
	DB.query(query, [insertData, req.params.uuid], (err, results) => {
		if (err) throw err

		res.redirect('/admin/trainees')
	})
})

/**
 * Trainee Delete Endpoint
 */
router.get('/delete/:uuid', (req, res) => {
	const query = 'DELETE FROM trainees WHERE uuid = ?;'
	DB.query(query, req.params.uuid, (err, results) => {
		if (err) throw err
		res.redirect('/admin/trainees')
	})
})

module.exports = router
