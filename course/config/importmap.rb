# Use direct uploads for Active Storage (ignore)
pin "@rails/activestorage", to: "activestorage.esm.js"
pin "@rails/actioncable", to: "actioncable.esm.js"

# Hotwire
pin "@hotwired/turbo-rails", to: "@hotwired/turbo-rails-8.0.12.js"
pin "@hotwired/stimulus", to: "@hotwired/stimulus-3.2.2.js"

# Local files
pin "application", to: "application.js"
pin "controllers", to: "controllers/index.js"
pin "controllers/application", to: "controllers/application.js"
