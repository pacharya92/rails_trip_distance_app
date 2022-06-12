import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request"

export default class extends Controller {
  connect(){
    console.log("[Stimulus] successfully connected to the country_controller.js");
  }
  change(event) {
    // event.target.selectedOptions[0].value is equal to the country code
    // Example: United States -> Country_Code = US 
    let country = event.target.selectedOptions[0].value
    console.log(event.target.selectedOptions[0].value)
  }
}
