# frozen_string_literal: true

class Firebase::AuthController < ApplicationController
  before_action :authenticate_user!, only: [:link_account]

  # POST /firebase/auth
  def auth
    token = params[:id_token]
    
    unless token
      render json: { error: 'ID token is required' }, status: :bad_request
      return
    end

    # Check if Firebase is configured
    unless ENV['FIREBASE_PROJECT_ID']
      render json: { 
        error: 'Firebase not configured',
        message: 'Please set FIREBASE_PROJECT_ID environment variable',
        firebase_configured: false
      }, status: :service_unavailable
      return
    end

    payload = FirebaseAuthenticator.verify(token)
    
    unless payload
      render json: { 
        error: 'Invalid ID token',
        message: 'The provided Firebase ID token could not be verified',
        firebase_configured: true
      }, status: :unauthorized
      return
    end

    user = find_or_create_user_from_firebase(payload)
    
    if user.persisted?
      # Sign in the user using Devise
      sign_in(user)
      
      render json: {
        message: 'Authenticated successfully',
        user: user.as_json(except: [:jti]),
        firebase_payload: payload,
        firebase_configured: true
      }, status: :ok
    else
      render json: { error: 'Failed to create user', errors: user.errors }, status: :unprocessable_entity
    end
  end

  # POST /firebase/link
  def link_account
    token = params[:id_token]
    
    unless token
      render json: { error: 'ID token is required' }, status: :bad_request
      return
    end

    payload = FirebaseAuthenticator.verify(token)
    
    unless payload
      render json: { error: 'Invalid ID token' }, status: :unauthorized
      return
    end

    # Link Firebase account to existing user
    if current_user.update(firebase_uid: payload['sub'], provider: extract_provider(payload))
      render json: {
        message: 'Account linked successfully',
        user: current_user.as_json(except: [:jti])
      }, status: :ok
    else
      render json: { error: 'Failed to link account', errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  private

  def find_or_create_user_from_firebase(payload)
    firebase_uid = payload['sub']
    provider = extract_provider(payload)
    email = payload['email']
    
    # Find existing user by Firebase UID
    user = User.find_by(firebase_uid: firebase_uid, provider: provider)
    
    # If not found, try to find by email and link Firebase account
    unless user
      user = User.find_by(email: email)
      if user
        user.update!(firebase_uid: firebase_uid, provider: provider)
      end
    end
    
    # Create new user if still not found
    unless user
      # Extract name from Firebase payload or use defaults
      name = payload['name'] || email.split('@').first
      first_name = name.split(' ').first
      last_name = name.split(' ').last || ''
      
      user = User.create!(
        email: email,
        firebase_uid: firebase_uid,
        provider: provider,
        username: email.split('@').first + '_' + SecureRandom.hex(4),
        first_name: first_name,
        last_name: last_name,
        password: SecureRandom.hex(32) # Random password for Firebase users
      )
    end
    
    user
  end

  def extract_provider(payload)
    firebase_uid = payload['sub']
    
    case firebase_uid
    when /^google/
      'google'
    when /^facebook/
      'facebook'
    when /^email/
      'email'
    else
      'email'
    end
  end
end
