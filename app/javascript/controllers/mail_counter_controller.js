import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mail-counter"
export default class extends Controller {

  static values = {
    id: String
  }

  connect() {
  }

  increaseMailCounter() {
    const url = document.location.origin + `/mail_counters/${this.idValue}`
    fetch(url, {
      method: "PATCH",
      headers: {"Accept": "text/plain"},
    })
  }
}
