import { Controller } from "@hotwired/stimulus"
import {timeConvert} from './utilities.js';


// Connects to data-controller="item-comp"
export default class extends Controller {
  static targets = ["item", "source", "tweettext", "result", "rep", "mailtext", "tweet", "resultjet", "resultyacht", "fullresult", "resultexplain", "action"]

  connect() {
    console.log("test38")
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
      this.fullresultTarget.classList.remove("d-none")
      this.resultTarget.innerHTML = `Félicitations ! Grâce vos efforts, votre <strong>empreinte carbone</strong> diminue de <span class="key-number">${Number.parseInt(this.totalCarb)}</span>kgCO2e par an.`
      // this.resultTarget.insertAdjacentHTML("beforeend", `<br><br><div class="source">Source : informations récoltées par <a href="https://twitter.com/i_fly_Bernard" target="_blank">I Fly Bernard</a> et <a href="https://twitter.com/YachtCO2tracker" target="_blank">YachtCO2tracker</a> à partir de données provenant de <a href="https://www.eia.gov/environment/emissions/co2_vol_mass.php" target="_blank">l'U.S Energy Information Administration</a> et des <a href="https://www.mtu-solutions.com/content/dam/mtu/products/yacht/main-propulsion/mtu-series-4000/3232791_Marine_spec_16V4000M73-L_1B.pdf/_jcr_content/renditions/original./3232791_Marine_spec_16V4000M73-L_1B.pdf" target="_blank">données constructeur du navire</a></div>`)
      this.actionTarget.innerHTML = "<strong>Envie d'agir ?</strong><br><a data-item-comp-target='tweet' href='' target='_blank'>Partagez votre résultat sur Twitter</a> ou recherchez votre député.e pour l'interpeller :"
      this.tweetTarget.href = `https://twitter.com/intent/tweet?text=Mes efforts réduisent mon empreinte de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Ils sont annulés par la consommation carburant de ${timeConvert(this.totalJet)} de vol du jet de Vincent Bolloré, ou de ${Math.round(this.totalYacht)} kilomètres parcourus par le yacht de Bernard Arnault. Que font nos représentants ?&hashtags=quinousbrule`
      this.repTarget.classList.remove("d-none")
      this.tweettextTarget.innerText = `Mes efforts réduisent mon empreinte de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Ils sont annulés par la consommation carburant de ${timeConvert(this.totalJet)} de vol du jet de Vincent Bolloré, ou de ${Math.round(this.totalYacht)} kilomètres parcourus par le yacht de Bernard Arnault. Que font nos représentants ?&hashtags=quinousbrule`
      this.mailtextTarget.innerText = `Le site quinousbrule.fr m'a permis de réaliser que mes efforts réduisent mon empreinte carbone de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Ils sont annulés par la consommation carburant de ${timeConvert(this.totalJet)} de vol du jet de Vincent Bolloré, ou de ${this.totalYacht.toFixed(2)} kilomètres parcourus par le yacht de Bernard Arnault.%0D%0A%0D%0AQue faites-vous pour lutter contre les vrais responsables du réchauffement climatique ?%0D%0A%0D%0ACordialement,%0D%0A%0D%0AVOTRE NOM`
      if (this.totalJet < 1 || this.totalYacht < 2) {
        this.resultexplainTarget.innerHTML = `Il vous faudra adopter ce comportement pendant <strong><span class="key-number">${Number.parseFloat(4500/this.totalCarb).toFixed(0)}</span> années</strong> pour économiser la <strong>consommation de carburant</strong> de :`
        this.resultjetTarget.innerText = "1 heure"
        this.resultyachtTarget.innerText = "20 kilomètres"
          // this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Il vous faudra adopter ce comportement pendant <strong>${Number.parseFloat(4500/this.totalCarb).toFixed(2)} ans</strong> pour économiser: <br><br> 🛩 la consommation carbone de <strong>60 minutes</strong> de vol du jet privé de Vincent Bolloré<br> 🛥 <strong>20 kilomètres</strong> parcourus par le yacht de Bernard Arnault.`)
        } else {
        this.resultexplainTarget.innerHTML = `Malheureusement, c'est <strong>l'équivalent de <br>la consommation de carburant</strong> de :`
        this.resultjetTarget.innerText = `${timeConvert(this.totalJet.toFixed(0))}`
        this.resultyachtTarget.innerText = `${this.totalYacht.toFixed(0)} kilomètres`
        }
        // if (this.totalJet < 50) {
        //   this.resultexplainTarget.innerHTML = `Il vous faudra adopter ce comportement pendant <span class="key-number">${Number.parseFloat(9000/this.totalCarb).toFixed(0)}</span> années pour économiser la consommation carbone de :`
        //   this.resultjetTarget.innerText = "2 heures"
        //   this.resultyachtTarget.innerText = "40 kilomètres"
        //   // this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Il vous faudra adopter ce comportement pendant <strong>${Number.parseFloat(9000/this.totalCarb).toFixed(2)} ans</strong> pour économiser: <br><br> 🛩 la consommation carbone de <strong>2 heures</strong> de vol du jet privé de Vincent Bolloré<br> 🛥 <strong>40 kilomètres</strong> parcourus par le yacht de Bernard Arnault.`)
        // } else if (this.totalJet < 100) {
        //   this.resultexplainTarget.innerHTML = `Il vous faudra adopter ce comportement pendant <span class="key-number">${Number.parseFloat(18000/this.totalCarb).toFixed(0)}</span> années pour économiser la consommation carbone de :`
        //   this.resultjetTarget.innerText = "4 heures"
        //   this.resultyachtTarget.innerText = "80 kilomètres"
        //   // this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Il vous faudra adopter ce comportement pendant <strong>${Number.parseFloat(18000/this.totalCarb).toFixed(2)} ans</strong> pour économiser: <br><br> 🛩 la consommation carbone de <strong>4 heures</strong> de vol du jet privé de Vincent Bolloré<br> 🛥 <strong>80 kilomètres</strong> parcourus par le yacht de Bernard Arnault.`)
        // } else if (this.totalJet < 200) {
        //   this.resultexplainTarget.innerHTML = `Il vous faudra adopter ce comportement pendant <span class="key-number">${Number.parseFloat(36000/this.totalCarb).toFixed(0)}</span> années pour économiser la consommation carbone de :`
        //   this.resultjetTarget.innerText = "8 heures"
        //   this.resultyachtTarget.innerText = "160 kilomètres"
        //   // this.resultTarget.insertAdjacentHTML("beforeend", `<br><br>Il vous faudra adopter ce comportement pendant <strong>${Number.parseFloat(36000/this.totalCarb).toFixed(2)} ans</strong> pour économiser: <br><br> 🛩 la consommation carbone de <strong>8 heures</strong> de vol du jet privé de Vincent Bolloré<br> 🛥 <strong>160 kilomètres</strong> parcourus par le yacht de Bernard Arnault.`)
        // }
      } else {
        this.fullresultTarget.classList.add("d-none")
        this.repTarget.classList.add("d-none")
    }
  }
}
