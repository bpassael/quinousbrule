import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mail-counter"
export default class extends Controller {

  static values = {
    id: String
  }

  connect() {
    console.log("MAIL CONNECTED")
  }

  increaseMailCounter() {
    const url = document.location.origin + `/mail_counters/${this.idValue}`
    console.log(url)
    fetch(url, {
      method: "PATCH",
      headers: {"Accept": "text/plain"},
    })
  }
}


// bind to all mail buttons
