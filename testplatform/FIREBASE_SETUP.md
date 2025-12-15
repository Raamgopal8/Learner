# Firebase Authentication Setup for Tutorx Test Platform

This document provides instructions for setting up Firebase authentication in the Tutorx test platform Rails application.

## Overview

The Firebase authentication system has been integrated into the test platform to provide secure, modern authentication with support for:
- Email/Password authentication
- Google OAuth authentication  
- JWT token management
- Account linking between Firebase and existing users

## Prerequisites

1. Create a Firebase project at https://console.firebase.google.com
2. Enable Authentication in your Firebase project
3. Configure authentication providers (Email/Password, Google, etc.)

## Firebase Project Setup

### 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Click "Add project"
3. Enter project name (e.g., "tutorx-test-platform")
4. Follow the setup wizard

### 2. Enable Authentication

1. In Firebase Console, go to "Authentication" → "Sign-in method"
2. Enable "Email/Password" provider
3. Enable "Google" provider (if needed)
4. Configure authorized domains for your application

### 3. Get Firebase Configuration

1. In Firebase Console, go to Project Settings → General
2. Under "Your apps", click the web app icon (</>)
3. Copy the Firebase configuration object
4. Update the configuration in:
   - `app/views/auth/login.html.erb`
   - `app/views/auth/signup.html.erb`

### 4. Get Project ID

1. In Firebase Console, go to Project Settings → General
2. Copy the "Project ID"
3. Set it as environment variable: `FIREBASE_PROJECT_ID`

## Environment Variables

Create a `.env` file in the testplatform directory with:

```bash
# Database Configuration
DATABASE_PASSWORD=postgres

# Firebase Configuration
FIREBASE_PROJECT_ID=your-firebase-project-id

# Rails Secret Key Base
SECRET_KEY_BASE=your-secret-key-base-here
```

## Database Migration

Run the migration to add Firebase fields to the User model:

```bash
rails db:migrate
```

## Updated Files

### Backend Changes

1. **Gemfile** - Added `devise-jwt` gem for JWT authentication
2. **User Model** - Added Firebase authentication support
3. **Firebase::AuthController** - Handles Firebase token verification
4. **ApplicationController** - Supports both JWT and Firebase authentication
5. **Routes** - Added Firebase authentication endpoints
6. **Migration** - Added `firebase_uid` and `provider` fields to users table

### Frontend Changes

1. **Login Page** (`/login`) - Firebase authentication UI
2. **Signup Page** (`/signup`) - Firebase registration UI
3. **Firebase JavaScript SDK** - Integrated into auth pages

## API Endpoints

### Firebase Authentication

- `POST /firebase/auth` - Authenticate with Firebase ID token
- `POST /firebase/link` - Link Firebase account to existing user

### Auth Pages

- `GET /login` - Login page
- `GET /signup` - Signup page  
- `GET /profile` - User profile (requires authentication)
- `POST /logout` - Logout endpoint

## Authentication Flow

1. User signs in/up via Firebase (Google or Email/Password)
2. Firebase returns an ID token
3. Frontend sends ID token to `/firebase/auth`
4. Backend verifies token using `FirebaseAuthenticator` service
5. Backend creates/updates user and returns JWT token
6. Frontend stores JWT token for subsequent requests

## Security Features

- Firebase ID token verification using Google's public keys
- JWT token management with Devise-JWT
- Automatic account linking by email
- CSRF protection
- Unique constraints on Firebase UID

## Testing the Implementation

1. Start the Rails server: `rails server`
2. Navigate to `http://localhost:3000/login`
3. Test Google sign-in or Email/Password authentication
4. Verify user creation in the database

## Troubleshooting

### Common Issues

1. **"Invalid ID token" errors**
   - Check Firebase project ID in environment variables
   - Verify Firebase configuration in frontend
   - Ensure authentication providers are enabled in Firebase

2. **Database connection errors**
   - Set DATABASE_PASSWORD environment variable
   - Ensure PostgreSQL is running

3. **JWT token issues**
   - Check devise-jwt configuration in `config/initializers/devise.rb`
   - Verify secret_key_base is set

### Debug Logging

Enable debug logging in `FirebaseAuthenticator` by checking Rails logs for token verification errors.

## Next Steps

1. Configure Firebase project with your specific settings
2. Update Firebase configuration in the frontend files
3. Set up environment variables
4. Test the authentication flow
5. Customize the UI as needed
6. Add additional authentication providers if required

## Support

For Firebase-related issues, consult the [Firebase Documentation](https://firebase.google.com/docs/auth).
For Rails integration issues, check the application logs and ensure all gems are properly installed.
