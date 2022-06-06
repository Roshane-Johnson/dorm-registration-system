console.info('Admin Trainee')

for (const element of document.getElementsByClassName('delBtn')) {
	element.onclick = (e) => {
		e.preventDefault()

		const nextUrl = e.target.href
		const confirmation = confirm(`Are you sure you want to delete ${e.target.dataset.trainee_name}?\n(this action can't be reversed)`)

		confirmation ? (document.location.href = nextUrl) : null
	}
}
