import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="display-result"
export default class extends Controller {
  static targets = ["form", "caroussel", "comparated", "annualfp", "jetmn", "kmyacht", "tweet"]
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
        console.log(data)
        let result = data.match(/"resultvalue">([\d\.]+)/)
        result = result[1]
        console.log(result)
        const annualFootprint = Number.parseFloat(result).toFixed(2)
        const jetComparaison = (Number.parseInt(result)/78).toFixed(2)
        const yachtComparaison = (Number.parseInt(result)/230).toFixed(2)
        //const resultContent = `Votre empreinte carbone annuelle est de ${result} kgCCO2e. Cela correspond à la consommation en carburant de ${Number.parseInt(result)/78} minutes de vol du jet privé de Vincent Bolloré, ou de ${Number.parseInt(result)/230} kilomètres parcourus par le yacht de Bernard Arnault.`
        this.carousselTarget.classList.toggle('d-none')
        this.comparatedTarget.classList.toggle('d-none')
        this.annualfpTarget.innerText = annualFootprint
        this.jetmnTarget.innerText = jetComparaison
        this.kmyachtTarget.innerText = yachtComparaison
        this.tweetTarget.href = `https://twitter.com/intent/tweet?text=Mon empreinte C02 annuelle est de ${annualFootprint} kgCO2e. Cela correspond à la consommation carburant de ${jetComparaison} minutes de vol du jet privé de Vincent Bolloré, ou de ${yachtComparaison} kilomètres parcourus par le yacht de Bernard Arnault. Que font nos représentants ? &hashtags=quinousbrule`

      })
  }
}
