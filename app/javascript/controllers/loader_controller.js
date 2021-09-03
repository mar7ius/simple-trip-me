import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["modal", "submit"]

  // connect() {
  //   // this.outputTarget.textContent = 'Hello, Stimulus!'
  //   console.log(this.modalTarget)
  //   console.log(this.submitTarget)
  // }

  submit() {
    this.modalTarget.classList.remove('d-none');
  }
}
