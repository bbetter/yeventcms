import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "results"]

    connect() {
        this.timeout = null
    }

    search() {
        clearTimeout(this.timeout)
        this.timeout = setTimeout(() => {
            const query = this.inputTarget.value
            const url = new URL(window.location.href)
            url.searchParams.set('search', query)
            fetch(url, {
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            })
                .then(response => response.text())
                .then(html => {
                    const parser = new DOMParser()
                    const doc = parser.parseFromString(html, 'text/html')
                    const newTableBody = doc.querySelector('#events-table tbody')
                    document.getElementsByTagName("tbody")[0].innerHTML =  newTableBody.innerHTML
                })
        }, 300)
    }
}