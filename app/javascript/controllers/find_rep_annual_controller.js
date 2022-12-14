import { Controller } from "@hotwired/stimulus"
import {isValidAddressInput, formatInput, get_code3_dep, inside} from './utilities.js';


// Connects to data-controller="find-rep-annual"
export default class extends Controller {
  static targets = ["input", "represult", "photo", "twitterhandletext", "twitterlink", "mailheadertext", "mailtolink"]

  connect() {
  }



  find(event) {
    event.preventDefault()
    if (isValidAddressInput(this.inputTarget.value) === "") {
      this.represultTarget.innerText = "Nous n'avons pas trouvé, ressaisissez votre adresse"
      this.inputTarget.value = ""
      return
    }
    this.represultTarget.innerHTML = `<span class="thin">Nous recherchons votre député.e <span>...</span></span>`
    // <span class="dots"></span>
    // var dots = new Typed('.dots', {
    //   strings: ["..............................................................."],
    //   typeSpeed: 100
    // });
    const url = `https://api-adresse.data.gouv.fr/search/?q=${formatInput(this.inputTarget.value)}`
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        if (data['features'].length === 0) {
          this.represultTarget.innerText = "Nous n'avons pas trouvé, ressaisissez votre adresse"
          return
        }

        const address = data['features'][0]['properties']['label']
        const [lon, lat] = data['features'][0]['geometry']['coordinates']
        const dpt = get_code3_dep(data['features'][0]['properties']["context"].split(',')[0])
        fetch('https://justcors.com/l_4vuqod9q6y/https://unicornvape.com/circopols.json')
          .then(response => response.json())
          .then((data) => {
            const possible_polys = []
            for (let poly of data["features"]) {
              if (dpt === poly['properties']['REF'].substring(0, 3)) {
                possible_polys.push(poly)
              }
            }
            for (let poly of possible_polys) {
              if (inside([lon, lat], poly['geometry']['coordinates'][0])) {
                var circo = poly['properties']['REF']
              }
            }
            fetch('./deputes.json')
              .then(response => response.json())
              .then((data) => {
                for (let rep of data) {
                  if (circo === rep['code_circo']) {
                    const rep_name = rep['nom']
                    const rep_email = rep['emails']
                    const rep_twitter = rep['twitter']
                    this.twitterhandletextTarget.insertAdjacentText("afterbegin",`https://twitter.com/intent/tweet?text=@${rep_twitter} `)
                    this.twitterlinkTarget.href = this.twitterhandletextTarget.innerText
                    this.twitterlinkTarget.classList.remove("d-none")
                    this.mailheadertextTarget.insertAdjacentText("afterbegin",`mailto:${rep_email}?subject=A quoi servent mes efforts ?&body=Madame la députée, Monsieur le député,%0D%0A%0D%0A `)
                    this.mailtolinkTarget.href = this.mailheadertextTarget.innerText
                    this.mailtolinkTarget.classList.remove("d-none")
                    this.represultTarget.innerHTML = `Votre député.e est <strong>${rep_name}</strong><br><em>(pour l'adresse : ${address})</em>.`
                  }
                }
              })
          })
    })
  }
}
