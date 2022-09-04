import { Controller } from "@hotwired/stimulus"
import {timeConvert} from './utilities.js';

// Connects to data-controller="display-result"
export default class extends Controller {
  static targets = ["form", "caroussel", "comparated", "annualfp", "jetmn", "kmyacht", "tweet"]
  connect() {
    console.log("test5")
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
        this.jetmnTarget.innerText = jetComparaison
        this.kmyachtTarget.innerText = yachtComparaison
        this.tweetTarget.href = `https://twitter.com/intent/tweet?text=Mon empreinte CO2 annuelle est de ${annualFootprint} kgCO2e. Cela correspond à la consommation carburant de ${jetComparaison} de vol du jet privé de Vincent Bolloré, ou de ${yachtComparaison} kilomètres parcourus par le yacht de Bernard Arnault. Que font nos représentants ? &hashtags=quinousbrule`

      })
  }







}
