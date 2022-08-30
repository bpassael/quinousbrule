import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="item-comp"
export default class extends Controller {
  static targets = ["item", "result"]
  // static values = {
  //   carbon: Number,
  //   jet: Number,
  //   yacht: Number}

  connect() {
    // this.totalYacht = 0
    // this.totalJet = 0
  }

  selected(event) {
    this.totalCarb = 0
    event.currentTarget.classList.toggle("item-element-selected")
    event.currentTarget.classList.toggle("item-element")
      console.log(typeof(this.element.getElementsByClassName("d-none")));
      let carbValues = this.element.getElementsByClassName("d-none")
      carbValues = Object.values(carbValues)
      carbValues.forEach((carbValue) => {
        console.log(carbValue.innerText);
        if (event.currentTarget.classList.contains("item-element-selected")) {
          this.totalCarb += Number.parseInt(carbValue.innerText, 10);
        }
      });
      console.log("real :"+this.totalCarb)
        // currentTarget.getElementByClassName("d-none"))
      // this.totalCarb += event.currentTarget.carbonValue
      // console.log(this.totalCarb)
      // this.totalYacht += this.yachtValue
      // this.totalJet += this.jetValue
  }
}
