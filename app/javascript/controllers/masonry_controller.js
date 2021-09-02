import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["img"]

  connect() {

  }

  toggleAnimate(e) {
    this.imgTargets.forEach((img) => {
      if (window.innerHeight >= img.getBoundingClientRect().top) {
        if (!img.classList.contains("animate")) {
          img.classList.add("animate")
        }
      }
    })
  }
}
