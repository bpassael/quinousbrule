import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-result"
export default class extends Controller {
  static targets = ["form", "caroussel"]
  connect() {
    console.log("test15")
  }

  display(event) {
    event.preventDefault()
    const url = this.formTarget.action
    fetch(url, {
      method: "POST",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        console.log(data)
        let result = data.match(/"resultvalue">([\d\.]+)/)
        result = result[1]
        console.log(result)
        result = Number.parseFloat(result).toFixed(2)
        this.carousselTarget.innerHTML = result
      })
  }
}
