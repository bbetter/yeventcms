import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="attachment"
export default class extends Controller {
  static targets = ["image", "modal", "title", "pdfEmbed", "attachmentsContent"]

  connect() {
    console.log("Attachment controller connected")
    this.createModal();
    this.initializeModal();
    this.initializeSlider();
  }

  initializeModal() {
    console.log("Initializing modal")
    this.element.querySelectorAll('.attachment-img').forEach(link => {
      link.addEventListener('click', this.showModal.bind(this))
    });

    document.addEventListener('click', this.outsideClick.bind(this));
  }

  initializeSlider() {
    console.log("Initializing slider")
    this.element.querySelectorAll('.attachments-slider').forEach(slider => {
      slider.querySelectorAll('.slider-nav').forEach(button => {
        button.addEventListener('click', this.scrollAttachments.bind(this))
      })
    })
  }

  closeModal() {
    if (this.modalElement) {
      this.modalElement.style.display = 'none';
      document.body.style.overflow = '';
    } else {
      console.error("Modal element not found.");
    }
  }

  outsideClick(event) {
    if (this.modalElement && event.target === this.modalElement) {
      this.closeModal();
    }
  }

  createModal() {
    const modalHTML = `
      <div class="modal" data-attachment-target="modal" style="display: none;">
          <div class="modal-dialog">
              <div class="modal-content">
                  <div class="modal-header">
                      <h5 class="modal-title" data-attachment-target="title">Вкладення</h5>
                      <button type="button" class="close" aria-label="Close" data-action="click->attachment#closeModal">
                          <span aria-hidden="true">&times;</span>
                      </button>
                  </div>
                  <div class="modal-body">
                      <div class="attachment-viewer">
                          <img src="" alt="Вкладення" class="img-fluid" data-attachment-target="image" style="display: none;">
                          <embed src="" data-attachment-target="pdfEmbed" style="display: none; width: 100%; height: 500px;" type="application/pdf">
                      </div>
                  </div>
              </div>
          </div>
      </div>
    `;
    document.body.insertAdjacentHTML('beforeend', modalHTML);

    // Update targets manually
    this.modalElement = document.querySelector('[data-attachment-target="modal"]');
    this.titleElement = this.modalElement.querySelector('[data-attachment-target="title"]');
    this.imageElement = this.modalElement.querySelector('[data-attachment-target="image"]');
    this.pdfEmbedElement = this.modalElement.querySelector('[data-attachment-target="pdfEmbed"]');
    this.modalElement.querySelector('.close').addEventListener('click', this.closeModal.bind(this));
  }

  showModal(event) {
    const link = event.currentTarget;
    const fileUrl = link.getAttribute('data-url');
    const title = link.getAttribute('data-title');
    const contentType = link.getAttribute('data-type');

    console.log("Show modal triggered", { fileUrl, title, contentType });

    if (!this.modalElement) {
      this.createModal();
    }

    console.log("Modal elements", { modalElement: this.modalElement, titleElement: this.titleElement, imageElement: this.imageElement, pdfEmbedElement: this.pdfEmbedElement });

    if (this.modalElement && this.titleElement) {
      this.titleElement.textContent = title;

      // Hide all content types
      this.imageElement.style.display = 'none';
      this.pdfEmbedElement.style.display = 'none';

      if (contentType.startsWith('image/')) {
        // If it's an image
        this.imageElement.src = fileUrl;
        this.imageElement.style.display = 'block';
      } else if (contentType === 'application/pdf') {
        // If it's a PDF
        this.pdfEmbedElement.src = fileUrl;
        this.pdfEmbedElement.style.display = 'block';
      } else {
        // For other file types
        console.error("Unsupported file type.");
      }

      this.modalElement.style.display = 'flex';
      document.body.style.overflow = 'hidden';
    } else {
      console.error("Modal elements not found.");
    }
  }

  scrollAttachments(event) {
    console.log("Scrolling attachments")
    const button = event.currentTarget;
    const direction = parseInt(button.dataset.direction, 10);
    const slider = button.closest('.attachments-slider').querySelector('.attachments-list');
    const scrollAmount = 300;
    console.log('Scroll button clicked', { direction, scrollAmount });
    slider.scrollBy({
      left: direction * scrollAmount,
      behavior: 'smooth'
    });
  }

  toggle() {
    if (this.attachmentsContentTarget.style.display === "none" || this.attachmentsContentTarget.style.display === "") {
      this.attachmentsContentTarget.style.display = "block";
      this.attachmentsContentTarget.classList.add("expanded");
    } else {
      this.attachmentsContentTarget.style.display = "none";
      this.attachmentsContentTarget.classList.remove("expanded");
    }
  }
}