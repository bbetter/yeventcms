import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="category"
export default class extends Controller {
  static targets = ["newCategoryCheckbox", "newCategoryInput", "categorySelect"]

  connect() {
    this.toggleNewCategoryInput()
  }

  toggleNewCategoryInput() {
    if (this.newCategoryCheckboxTarget.checked) {
      this.newCategoryInputTarget.style.display = 'block'
      this.categorySelectTarget.disabled = true
    } else {
      this.newCategoryInputTarget.style.display = 'none'
      this.categorySelectTarget.disabled = false
    }
  }

  toggle() {
    this.toggleNewCategoryInput()
  }
}