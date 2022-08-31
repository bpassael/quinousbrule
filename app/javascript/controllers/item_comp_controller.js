import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="item-comp"
export default class extends Controller {
  static targets = ["item", "result", "source"]

  connect() {
  }

  selected(event) {
    this.totalCarb = 0
    this.totalJet = 0
    this.totalYacht = 0
    event.currentTarget.classList.toggle("item-element-selected")
    event.currentTarget.classList.toggle("item-element")
      const carbValues = this.element.getElementsByClassName("item-element-selected")
      console.log(carbValues)
      const range = [...Array(Object.keys(carbValues).length).keys()];
      range.forEach((e) => {
        this.totalCarb += Number.parseFloat(carbValues[e]["childNodes"][3]["innerHTML"])
        this.totalJet += Number.parseFloat(carbValues[e]["childNodes"][5]["innerHTML"])
        this.totalYacht += Number.parseFloat(carbValues[e]["childNodes"][7]["innerHTML"])
      })
      if (this.totalCarb != 0) {
      this.resultTarget.innerText = `Félicitations ! Votre empreinte carbone diminue de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Ces efforts sont annulés par la consommation en carburant de ${this.totalJet.toFixed(2)} minutes de vol du jet privé de Vincent Bolloré, ou de ${this.totalYacht.toFixed(2)} kilomètres parcourus par le yacht de Bernard Arnault.`
    } else {
      this.resultTarget.innerText = "Cochez une ou plusieurs cases pour estimer vos économies carbone"
    }
    if (this.totalJet < 30 && this.totalCarb != 0) {
      this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Il vous faudra adopter ce comportement pendant ${Number.parseInt(4500/this.totalCarb)} ans pour économiser la consommation carbone de 60 minutes de vol du jet privé de Vincent Bolloré, ou de 20 kilomètres parcourus par le yacht de Bernard Arnault.`)
    }
  }
}
