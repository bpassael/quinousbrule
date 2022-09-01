import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="annual-calc"
export default class extends Controller {
  static targets = ["plane", "car", "train", "moto", "scooter", "textmoto"]

  connect() {
    console.log("hey")
  }

  displayplane() {
    this.planeTarget.classList.toggle("d-none")
  }

  displaycar() {
    this.carTarget.classList.toggle("d-none")
  }

  displaytrain() {
    this.trainTarget.classList.toggle("d-none")
  }

  displaymoto(event) {
    if (event.currentTarget.value == "Moto > 250") {
      this.textmotoTarget.classList.remove("d-none")
      this.motoTarget.classList.remove("d-none")
      this.scooterTarget.classList.add("d-none")
    } else if (event.currentTarget.value == "Scooter ou moto < 250") {

    }
  }
}
