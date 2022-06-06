console.info('Admin Navbar')

const traineeTrigger = document.getElementById('trn_trigger')
const traineeList = document.getElementById('trn_list')

if (currentPage('/admin/trainees') || currentPage('/admin/trainees/add')) {
	traineeList.classList.remove('hidden')
}

if (currentPage('/admin/trainees')) {
	const element = traineeList.children[0]
	element.style.backgroundColor = 'rgb(185, 215, 253)'
	element.style.color = 'rgb(37, 99, 235)'
}
if (currentPage('/admin/trainees/add')) {
	let element = traineeList.children[1]
	element.style.backgroundColor = 'rgb(185, 215, 253)'
	element.style.color = 'rgb(37, 99, 235)'
}

toggleList(traineeTrigger, traineeList)

/** Markesheet JS */

const marksheetTrigger = document.getElementById('mks_trigger')
const marksheetList = document.getElementById('mks_list')

if (currentPage('/admin/marksheet') || currentPage('/admin/marksheet/history')) {
	marksheetList.classList.remove('hidden')
}

if (currentPage('/admin/marksheet')) {
	const element = marksheetList.children[0]
	element.style.backgroundColor = 'rgb(185, 215, 253)'
	element.style.color = 'rgb(37, 99, 235)'
}
if (currentPage('/admin/marksheet/history')) {
	const element = marksheetList.children[1]
	element.style.backgroundColor = 'rgb(185, 215, 253)'
	element.style.color = 'rgb(37, 99, 235)'
}

toggleList(marksheetTrigger, marksheetList)

/**
 *
 * @param {HTMLElement} trigger The element that toggles the list, often times a button for a dropdown list
 * @param {HTMLElement} list The element being toggled by the trigger, often time the dropdown list content
 * @returns void
 */
function toggleList(trigger, list) {
	trigger.onclick = (e) => {
		e.preventDefault()

		if (list.classList.contains('hidden')) {
			list.classList.remove('hidden')
		} else {
			list.classList.add('hidden')
		}
	}
}

/**
 *
 * @param {string} urlPathName The pathname of the page your checking for, it defaults to "/"
 * @returns boolean
 */
function currentPage(urlPathName = '/') {
	if (location.pathname == urlPathName) {
		return true
	} else {
		return false
	}
}
