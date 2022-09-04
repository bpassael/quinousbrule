import { Controller } from "@hotwired/stimulus"
import {formatInput, get_code3_dep, inside} from './utilities.js';

// Connects to data-controller="find-rep"
export default class extends Controller {
  static targets = ["input", "result", "photo"]

  connect() {
  }


  find(event) {
    event.preventDefault()
    const url = `https://api-adresse.data.gouv.fr/search/?q=${formatInput(this.inputTarget.value)}`
    console.log(url)
    fetch(url)
      .then(response => response.json())
      .then((data) => {
        if (data['features'].length === 0) {
          this.resultTarget.innerText = "Nous n'avons pas trouvé, ressaisissez votre adresse"
          return
        }
        this.resultTarget.innerText = "Nous recherchons votre député.e ..."
        const address = data['features'][0]['properties']['label']
        console.log(address)
        const [lon, lat] = data['features'][0]['geometry']['coordinates']
        console.log([lon, lat])
        const dpt = get_code3_dep(data['features'][0]['properties']["context"].split(',')[0])
        fetch('./circopols.json')
          .then(response => response.json())
          .then((data) => {
            const possible_polys = []
            for (let poly of data["features"]) {
              if (dpt === poly['properties']['REF'].substring(0, 3)) {
                console.log(poly['properties']['REF'])
                possible_polys.push(poly)
              }
            }
            console.log("POSSIBLE POLYS")
            console.log(possible_polys)
            for (let poly of possible_polys) {
              if (inside([lon, lat], poly['geometry']['coordinates'][0])) {
                console.log("THIS IS THE CIRCO")
                var circo = poly['properties']['REF']
                console.log(circo)
              }
            }
            fetch('./deputes.json')
              .then(response => response.json())
              .then((data) => {
                for (let rep of data) {
                  if (circo === rep['code_circo']) {
                    const rep_name = rep['nom']
                    this.resultTarget.innerHTML = `Votre adresse est <strong>${address}</strong>.<br><br>Votre député.e est <strong>${rep_name}</strong>.`
                  }
                }
              })
          })
    })
  }
}
