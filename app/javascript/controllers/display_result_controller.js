import { Controller } from "@hotwired/stimulus"
import {timeConvert} from './utilities.js';

// Connects to data-controller="display-result"
export default class extends Controller {
  static targets = ["form", "caroussel", "comparated", "annualfp", "jetmn", "kmyacht", "tweet", "tweettext", "mailtext", "action"]
  connect() {
    console.log("Test display 1")
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
        console.log(data)
        let result = data.match(/"resultvalue">([\d\.]+)/)
        result = result[1]
        console.log(result)
        const annualFootprint = Math.round(Number.parseFloat(result))
        const jetComparaison = timeConvert((Number.parseInt(result)/78))
        const yachtComparaison = Math.round(Number.parseInt(result)/230)
        //const resultContent = `Votre empreinte carbone annuelle est de ${result} kgCCO2e. Cela correspond à la consommation en carburant de ${Number.parseInt(result)/78} minutes de vol du jet privé de Vincent Bolloré, ou de ${Number.parseInt(result)/230} kilomètres parcourus par le yacht de Bernard Arnault.`
        this.carousselTarget.classList.toggle('d-none')
        this.comparatedTarget.classList.toggle('d-none')
        this.annualfpTarget.innerText = annualFootprint
        this.actionTarget.innerHTML = "<strong>Envie d'agir ?</strong><br><a data-item-comp-target='tweet' href='' target='_blank'>Partagez votre résultat sur Twitter</a> ou recherchez votre député.e pour l'interpeller :"
        this.jetmnTarget.innerText = jetComparaison
        this.kmyachtTarget.innerText = yachtComparaison
        this.tweetTarget.href = `https://twitter.com/intent/tweet?text=Mon empreinte CO2 annuelle est de ${annualFootprint} kgCO2e. Cela correspond à la consommation carburant de ${jetComparaison} de vol du jet privé de Vincent Bolloré, ou de ${yachtComparaison} kilomètres parcourus par le yacht de Bernard Arnault. Que font nos représentants ? &hashtags=quinousbrule`
        this.tweettextTarget.innerText = `Mon empreinte annuelle de ${annualFootprint} kgCO2e équivaut à ${jetComparaison} de vol du jet de Vincent Bolloré, ou ${yachtComparaison} kilomètres parcourus par le yacht de Bernard Arnault. Que faites-vous pour lutter contre les responsables du réchauffement climatique ?&hashtags=quinousbrule`
        this.mailtextTarget.innerText = `Le site quinousbrule.fr m'a permis de réaliser que mon empreinte carbone annuelle de ${annualFootprint} kgCO2e par an équivaut à la consommation carburant de ${jetComparaison} de vol du jet de Vincent Bolloré, ou de ${yachtComparaison} kilomètres parcourus par le yacht de Bernard Arnault.%0D%0A%0D%0AQue faites-vous pour lutter contre les vrais responsables du réchauffement climatique ?%0D%0A%0D%0ACordialement,%0D%0A%0D%0AVOTRE NOM`

      })
  }







}
