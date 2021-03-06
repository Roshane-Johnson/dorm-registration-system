require('dotenv').config()
const express = require('express')
const session = require('express-session')
const expressLayouts = require('express-ejs-layouts')
const cors = require('cors')
const path = require('path')
const flash = require('express-flash')
const AdminAuth = require('./routes/middlewares/auth')
const app = express()

let PORT = process.env.PORT || 8080
let APP_NAME = process.env.NAME || 'Express App'

// Express configs
app.set('view engine', 'ejs')
app.set('layout', 'layouts/layout')

// Middlewares
app.use(expressLayouts)
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(express.static(path.join(__dirname, 'public')))
app.use(cors(['*']))
app.use(flash())
app.use(
	session({
		secret: process.env.SESSION_SECRET || 'secret8080',
		resave: false,
		saveUninitialized: false,
		cookie: {
			maxAge: 1000 * 60 * 60 * 24, // day in milliseconds
		},
	})
)

// Middlewares
app.use('**admin**', AdminAuth)

// Authentication
app.use('/', require('./routes/auth'))

// View Routes
app.use('/', require('./routes/index'))
app.use('/admin', require('./routes/admin/index'))
app.use('/admin/trainees', require('./routes/admin/trainee'))
app.use('/admin/marksheet', require('./routes/admin/marksheet'))

// Start express app
app.listen(PORT, () => {
	console.log(`${APP_NAME} listening on http://localhost:${PORT}`)
})

// TODO Search feature for trainee
