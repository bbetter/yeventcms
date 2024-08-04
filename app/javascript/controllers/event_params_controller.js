// app/javascript/controllers/event_params_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["addNewEventParamCheckbox", "newEventParamsContainer", "addInputButton"]

  connect() {
    this.index = 0
    this.updateButtonVisibility()
  }

  toggle() {
    const shouldShow = this.addNewEventParamCheckboxTarget.checked
    this.newEventParamsContainerTarget.style.display = shouldShow ? "block" : "none"
    this.updateButtonVisibility()
  }

  addInput() {
    this.index++
    const container = document.createElement('div')
    container.className = 'input-group mb-3'

    const input = document.createElement('input')
    input.type = 'text'
    input.name = 'event[new_event_params][]'  // Ensure this uses array syntax
    input.className = 'form-control'
    input.placeholder = 'Назва параметра'

    const button = document.createElement('button')
    button.type = 'button'
    button.className = 'btn btn-danger'
    button.textContent = 'Видалити'
    button.addEventListener('click', () => container.remove())

    container.appendChild(input)
    container.appendChild(button)

    this.newEventParamsContainerTarget.appendChild(container)
  }

  updateButtonVisibility() {
    this.addInputButtonTarget.style.display = this.addNewEventParamCheckboxTarget.checked ? "block" : "none"
  }
}