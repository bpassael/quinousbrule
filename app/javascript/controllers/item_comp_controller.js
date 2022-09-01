import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="item-comp"
export default class extends Controller {
  static targets = ["item", "result", "source", "tweet"]

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
    if (this.totalJet < 20 && this.totalCarb != 0) {
      this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Il vous faudra adopter ce comportement pendant ${Number.parseFloat(4500/this.totalCarb).toFixed(2)} ans pour économiser la consommation carbone de 60 minutes de vol du jet privé de Vincent Bolloré, ou de 20 kilomètres parcourus par le yacht de Bernard Arnault.`)
    } else if (this.totalJet < 50 && this.totalCarb != 0) {
      this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Il vous faudra adopter ce comportement pendant ${Number.parseFloat(9000/this.totalCarb).toFixed(2)} ans pour économiser la consommation carbone de 2 heures de vol du jet privé de Vincent Bolloré, ou de 40 kilomètres parcourus par le yacht de Bernard Arnault.`)
    } else if (this.totalJet < 100 && this.totalCarb != 0) {
      this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Il vous faudra adopter ce comportement pendant ${Number.parseFloat(18000/this.totalCarb).toFixed(2)} ans pour économiser la consommation carbone de 4 heures de vol du jet privé de Vincent Bolloré, ou de 80 kilomètres parcourus par le yacht de Bernard Arnault.`)
    } else if (this.totalJet < 200 && this.totalCarb != 0) {
      this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Il vous faudra adopter ce comportement pendant ${Number.parseFloat(36000/this.totalCarb).toFixed(2)} ans pour économiser la consommation carbone de 8 heures de vol du jet privé de Vincent Bolloré, ou de 160 kilomètres parcourus par le yacht de Bernard Arnault.`)
    }
    this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Source : informations calculées par <a href="https://twitter.com/i_fly_Bernard" target="_blank">I Fly Bernard</a> et <a href="https://twitter.com/YachtCO2tracker" target="_blank">YachtCO2tracker</a> à partir de données provenant de <a href="https://www.eia.gov/environment/emissions/co2_vol_mass.php" target="_blank">l'U.S Energy Information Administration</a> et des <a href="https://www.mtu-solutions.com/content/dam/mtu/products/yacht/main-propulsion/mtu-series-4000/3232791_Marine_spec_16V4000M73-L_1B.pdf/_jcr_content/renditions/original./3232791_Marine_spec_16V4000M73-L_1B.pdf" target="_blank">données constructeur du navire</a>`)
    console.log(this.tweetTarget)
    this.tweetTarget.classList.remove("d-none")
    this.tweetTarget.href = `https://twitter.com/intent/tweet?text=Mes efforts réduisent mon empreinte CO2 de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Ils sont annulés par la consommation carburant de ${this.totalJet.toFixed(2)} minutes de vol du jet privé de Vincent Bolloré, ou de ${this.totalYacht.toFixed(2)} kilomètres parcourus par le yacht de Bernard Arnault. Que font nos représentants ? &hashtags=quinousbrule`

  }
}
