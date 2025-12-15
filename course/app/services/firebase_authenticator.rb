# frozen_string_literal: true

# Service object to verify Firebase ID tokens using Google's public keys.
# It relies on the `google-id-token` gem.
#
# Usage:
#   payload = FirebaseAuthenticator.verify(id_token)
#   # payload contains fields like "sub" (UID), "email", etc.
#   # Returns nil if verification fails.

class FirebaseAuthenticator
  # The Firebase project ID should be set in ENV['FIREBASE_PROJECT_ID']
  PROJECT_ID = ENV['FIREBASE_PROJECT_ID']

  # Verifies the given Firebase ID token.
  # Returns the decoded payload hash on success, or nil on failure.
  def self.verify(id_token)
    return nil unless id_token && PROJECT_ID
    validator = Google::IDToken::Validator.new
    # The audience can be omitted; Firebase tokens are signed for the project ID.
    validator.check(id_token, PROJECT_ID)
  rescue Google::IDToken::ValidationError => e
    Rails.logger.warn "Firebase token verification failed: #{e.message}" if defined?(Rails)
    nil
  end
end
