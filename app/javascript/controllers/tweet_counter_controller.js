import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tweet-counter"
export default class extends Controller {

  static values = {
    id: String,
  }

  connect() {
    console.log("TWEET CONNECTED")
  }

  increaseTweetCounter() {
    const url = document.location.origin + `/tweet_counters/${this.idValue}`
    console.log(url)
    fetch(url, {
      method: "PATCH",
      headers: {"Accept": "text/plain"},
    })
  }
}


// bind to all tweet buttons
