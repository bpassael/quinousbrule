import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tweet-counter"
export default class extends Controller {

  static values = {
    id: String,
  }

  connect() {
  }

  increaseTweetCounter() {
    const url = window.location.origin + `/tweet_counters/${this.idValue}`
    fetch(url, {
      method: "PATCH",
      headers: {"Accept": "text/plain"},
    })
  }
}
