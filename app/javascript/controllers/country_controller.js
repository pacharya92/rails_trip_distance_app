import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request"

export default class extends Controller {
  // Create targets for governing_district select field element
  // A governing district is a state/province/region etc...
  static targets = ["governingDistrictSelect"]

  connect(){
    console.log("[Stimulus] successfully connected to the country_controller.js");
  }
  change(event) {
    // event.target.selectedOptions[0].value is equal to the country code
    // Example: United States -> Country_Code = US 
    let country = event.target.selectedOptions[0].value
    
    // Get the select element id to be updated
    // "this" is given those properties from stimulus.js
    let target = this.governingDistrictSelectTarget.id
   
    // console.log(this)
    // console.log(this.governingDistrictSelectTarget)

    // Make request to a turbo-stream
    // target and country are passed in the params for use in the controller
    get(`/trips/governing_district?target=${target}&country=${country}`,{
      responseKind: 'turbo-stream'
    })
  }
}
