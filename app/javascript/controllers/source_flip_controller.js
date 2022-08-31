import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="source-flip"
export default class extends Controller {
  static targets = ["element", "source", "infos"]

  connect() {
  }

  return() {
    if (this.sourceTarget.classList.contains("d-none")) {
      this.sourceTarget.classList.remove("d-none")
      this.elementTarget.classList.add("d-none")
      this.infosTarget.classList.add("d-none")
    } else {
      this.sourceTarget.classList.add("d-none")
      this.elementTarget.classList.remove("d-none")
      this.infosTarget.classList.add("d-none")
    }
  }

  infos() {
    if (this.infosTarget.classList.contains("d-none")) {
      this.sourceTarget.classList.add("d-none")
      this.elementTarget.classList.add("d-none")
      this.infosTarget.classList.remove("d-none")
    } else {
      this.sourceTarget.classList.add("d-none")
      this.elementTarget.classList.remove("d-none")
      this.infosTarget.classList.add("d-none")
    }
  }
}
