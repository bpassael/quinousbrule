import { Controller } from "@hotwired/stimulus"
import {timeConvert} from './utilities.js';


// Connects to data-controller="item-comp"
export default class extends Controller {
  static targets = ["item", "source", "tweettext", "result", "rep", "mailtext", "tweet", "resultjet", "resultyacht", "fullresult", "resultexplain", "action", "simpleaction"]

  connect() {
  }



  selected(event) {
    this.totalCarb = 0
    this.totalJet = 0
    this.totalYacht = 0
    event.currentTarget.classList.toggle("item-element-selected")
    event.currentTarget.classList.toggle("item-element")
      const carbValues = this.element.getElementsByClassName("item-element-selected")
      const range = [...Array(Object.keys(carbValues).length).keys()];
      range.forEach((e) => {
        this.totalCarb += Number.parseFloat(carbValues[e]["childNodes"][3]["innerHTML"])
        this.totalJet += Number.parseFloat(carbValues[e]["childNodes"][5]["innerHTML"])
        this.totalYacht += Number.parseFloat(carbValues[e]["childNodes"][7]["innerHTML"])
      })
    if (this.totalCarb != 0) {
      this.fullresultTarget.classList.remove("d-none")
      this.resultTarget.innerHTML = `Félicitations ! Grâce vos efforts, votre <strong>empreinte carbone</strong> diminue de <span class="key-main-number">${Number.parseInt(this.totalCarb)}</span>kgCO2e par an.`
      // this.resultTarget.insertAdjacentHTML("beforeend", `<br><br><div class="source">Source : informations récoltées par <a href="https://twitter.com/i_fly_Bernard" target="_blank">I Fly Bernard</a> et <a href="https://twitter.com/YachtCO2tracker" target="_blank">YachtCO2tracker</a> à partir de données provenant de <a href="https://www.eia.gov/environment/emissions/co2_vol_mass.php" target="_blank">l'U.S Energy Information Administration</a> et des <a href="https://www.mtu-solutions.com/content/dam/mtu/products/yacht/main-propulsion/mtu-series-4000/3232791_Marine_spec_16V4000M73-L_1B.pdf/_jcr_content/renditions/original./3232791_Marine_spec_16V4000M73-L_1B.pdf" target="_blank">données constructeur du navire</a></div>`)
      this.actionTarget.innerHTML = "<strong>Envie d'agir ?</strong><br><br>Les député.e.s sont nos représentant.e.s.<br><strong>Recherchez votre député.e</strong> grâce à votre adresse postale pour l'interpeller par mail ou sur Twitter :"
      this.simpleactionTarget.innerHTML = "<a data-item-comp-target='tweet' data-action='click->tweet-counter#increaseTweetCounter' href='' target='_blank'>Partagez votre résultat sur Twitter</a><br><em>(sans tagguer votre député.e ou si vous le/la connaissez déjà)</em>."
      this.repTarget.classList.remove("d-none")
      if (this.totalJet < 1 || this.totalYacht < 2) {
        this.resultexplainTarget.innerHTML = `Il vous faudra adopter ce comportement pendant <strong><span class="key-number">${Math.round(Number.parseFloat(4500/this.totalCarb))}</span> années</strong> pour compenser la <strong>consommation de carburant</strong> de :`
        this.resultjetTarget.innerText = "1 heure"
        this.resultyachtTarget.innerText = "20 kilomètres"
        this.tweetTarget.href = `https://twitter.com/intent/tweet?text=Mes efforts réduisent mon empreinte carbone de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Il me faudrait ${Math.round(Number.parseFloat(4500/this.totalCarb))} ans pour compenser 1 heure de vol dans le jet privé de Vincent Bolloré ou 20km parcourus par le yacht de Bernard Arnault. https://pic.twitter.com/XnIujtmLWg&hashtags=quinousbrule`
        this.tweettextTarget.innerText = `Mes efforts réduisent mon empreinte carbone de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Il me faudrait ${Math.round(Number.parseFloat(4500/this.totalCarb))} ans pour compenser 1 heure de vol dans le jet privé de Vincent Bolloré ou 20km parcourus par le yacht de Bernard Arnault. https://pic.twitter.com/XnIujtmLWg&hashtags=quinousbrule`
        this.mailtextTarget.innerText = `Le site quinousbrule.fr m'a permis de réaliser que mes efforts réduisent mon empreinte carbone de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Il me faudrait ${Math.round(Number.parseFloat(4500/this.totalCarb))} ans pour compenser 1 heure de vol dans le jet privé de Vincent Bolloré ou 20km parcourus par le yacht de Bernard Arnault.%0D%0A%0D%0AQue faites-vous pour lutter contre les vrais responsables du réchauffement climatique ?%0D%0A%0D%0ACordialement,%0D%0A%0D%0AVOTRE NOM`
        } else {
        this.tweetTarget.href = `https://twitter.com/intent/tweet?text=Mes efforts réduisent mon empreinte carbone de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Ils sont annulés par ${timeConvert(this.totalJet)} de vol du jet de Vincent Bolloré, ou ${Math.round(this.totalYacht)}km parcourus par le yacht de Bernard Arnault. A quoi servent-ils ? https://pic.twitter.com/XnIujtmLWg&hashtags=quinousbrule`
        this.tweettextTarget.innerText = `Mes efforts réduisent mon empreinte carbone de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Ils sont annulés par ${timeConvert(this.totalJet)} de vol du jet de Vincent Bolloré, ou ${Math.round(this.totalYacht)}km parcourus par le yacht de Bernard Arnault. A quoi servent-ils ? https://pic.twitter.com/XnIujtmLWg&hashtags=quinousbrule`
        this.mailtextTarget.innerText = `Le site quinousbrule.fr m'a permis de réaliser que mes efforts réduisent mon empreinte carbone de ${Number.parseInt(this.totalCarb)} kgCO2e par an. Ils sont annulés par la consommation carburant de ${timeConvert(this.totalJet)} de vol du jet de Vincent Bolloré, ou de ${this.totalYacht.toFixed(2)} kilomètres parcourus par le yacht de Bernard Arnault.%0D%0A%0D%0AQue faites-vous pour lutter contre les vrais responsables du réchauffement climatique ?%0D%0A%0D%0ACordialement,%0D%0A%0D%0AVOTRE NOM`
        this.resultexplainTarget.innerHTML = `Malheureusement, c'est <strong>l'équivalent de <br>la consommation de carburant</strong> de :`
        this.resultjetTarget.innerText = `${timeConvert(this.totalJet.toFixed(0))}`
        this.resultyachtTarget.innerText = `${this.totalYacht.toFixed(0)} kilomètres`
        }
      } else {
        this.fullresultTarget.classList.add("d-none")
        this.repTarget.classList.add("d-none")
    }
  }
}
