import "@hotwired/turbo-rails"
import "@hotwired/stimulus"
import "controllers"

// Configure Stimulus
const application = Stimulus.Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
