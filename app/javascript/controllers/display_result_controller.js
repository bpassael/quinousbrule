import { Controller } from "@hotwired/stimulus"
import {timeConvert} from './utilities.js';

// Connects to data-controller="display-result"
export default class extends Controller {
  static targets = ["form", "caroussel", "comparated", "annualfp", "jetmn", "kmyacht", "tweet", "tweettext", "mailtext", "action", "simpleaction"]
  connect() {
  }


  display(event) {
    event.preventDefault()
    const url = this.formTarget.action
    fetch(url, {
      method: "POST",
      headers: { "Accept": "text/plain" },
      body: new FormData(this.formTarget)
    })
      .then(response => response.text())
      .then((data) => {
        let result = data.match(/"resultvalue">([\d\.]+)/)
        result = result[1]
        const annualFootprint = Number.parseFloat(result/1000).toFixed(2).replace(".",",")
        const jetComparaison = timeConvert((Number.parseInt(result)/78))
        const yachtComparaison = Math.round(Number.parseInt(result)/230)
        //const resultContent = `Votre empreinte carbone annuelle est de ${result} kgCCO2e. Cela correspond à la consommation en carburant de ${Number.parseInt(result)/78} minutes de vol du jet privé de Vincent Bolloré, ou de ${Number.parseInt(result)/230} kilomètres parcourus par le yacht de Bernard Arnault.`
        this.carousselTarget.classList.toggle('d-none')
        this.comparatedTarget.classList.toggle('d-none')
        this.annualfpTarget.innerText = annualFootprint
        this.actionTarget.innerHTML = "<strong>Envie d'agir ?</strong><br><br>Les député.e.s sont nos représentant.e.s.<br><strong>Recherchez votre député.e</strong> grâce à votre adresse postale pour l'interpeller par mail ou sur Twitter :"
        this.simpleactionTarget.innerHTML = "<a data-display-result-target='tweet' data-action='click->tweet-counter#increaseTweetCounter' href='' target='_blank'>Partagez votre résultat sur Twitter</a><br><em>(sans tagguer votre député.e ou si vous le/la connaissez déjà)</em>."
        this.jetmnTarget.innerText = jetComparaison
        this.kmyachtTarget.innerText = `${yachtComparaison} kilomètres`
        this.tweetTarget.href = `https://twitter.com/intent/tweet?text=Mon empreinte carbone annuelle est de ${annualFootprint} tonnes de CO2e soit ${jetComparaison} de vol du jet privé de Vincent Bolloré ou ${yachtComparaison}km parcourus par le yacht de Bernard Arnault. A quoi servent mes efforts ? https://pic.twitter.com/yg32d9s7Po&hashtags=quinousbrule`
        this.tweettextTarget.innerText = `Mon empreinte carbone annuelle est de ${annualFootprint} tonnes de CO2e soit ${jetComparaison} de vol du jet de Vincent Bolloré ou ${yachtComparaison}km parcourus par le yacht de Bernard Arnault. A quoi servent mes efforts ? https://pic.twitter.com/yg32d9s7Po&hashtags=quinousbrule`
        this.mailtextTarget.innerText = `Le site quinousbrule.fr m'a permis de réaliser que mon empreinte carbone annuelle de ${annualFootprint} tonnes de CO2e par an équivaut à la consommation carburant de ${jetComparaison} de vol du jet de Vincent Bolloré, ou de ${yachtComparaison} kilomètres parcourus par le yacht de Bernard Arnault.%0D%0A%0D%0AQue faites-vous pour lutter contre les vrais responsables du réchauffement climatique ?%0D%0A%0D%0ACordialement,%0D%0A%0D%0AVOTRE NOM`

      })
  }







}
