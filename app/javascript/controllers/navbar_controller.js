import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = [ "collapse" ];
  connect() {
    console.log("Hello, Stimulus!", this.element);
  }

  toggleCollapse() {
    this.collapseTarget.classList.toggle('show');
  }
}
