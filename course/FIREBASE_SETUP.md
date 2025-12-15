# Firebase Authentication Setup for Course Application

This document provides comprehensive instructions for setting up Firebase authentication in the Tutorx course application.

## Overview

The course application now supports Firebase authentication alongside the existing Devise authentication system. Users can sign in using:
- Google OAuth
- Email/Password authentication
- Existing Devise authentication

## Prerequisites

1. Firebase project created at https://console.firebase.google.com
2. Authentication enabled in Firebase console
3. Ruby gems installed (already added to Gemfile)

## Environment Variables

Add the following environment variables to your `.env` file:

```bash
# Firebase Configuration
FIREBASE_PROJECT_ID=your-firebase-project-id

# Rails Configuration
SECRET_KEY_BASE=your-secret-key-base
DATABASE_PASSWORD=your-db-password
```

## Firebase Project Setup

1. **Create Firebase Project**
   - Go to https://console.firebase.google.com
   - Click "Add project"
   - Follow the setup wizard

2. **Enable Authentication**
   - In Firebase console, go to Authentication
   - Click "Get started"
   - Enable Email/Password authentication
   - Enable Google authentication

3. **Get Firebase Configuration**
   - Go to Project Settings > General
   - Under "Your apps", click the web app icon
   - Copy the Firebase configuration object

4. **Update Firebase Configuration in Views**
   - Edit `app/views/home/login.html.erb`
   - Edit `app/views/home/signup.html.erb`
   - Replace the placeholder `firebaseConfig` object with your actual configuration

## Database Setup

Run the migration to add Firebase fields to the users table:

```bash
rails db:migrate
```

This adds:
- `firebase_uid` - Unique identifier from Firebase
- `provider` - Authentication provider (google, email, etc.)
- Unique indexes for data integrity

## Backend Implementation

### Firebase Authentication Service
- Location: `app/services/firebase_authenticator.rb`
- Verifies Firebase ID tokens using Google's public keys
- Returns decoded payload or nil on failure

### Firebase Authentication Controller
- Location: `app/controllers/firebase/auth_controller.rb`
- Handles POST `/firebase/auth` endpoint
- Creates or finds users based on Firebase data
- Signs in users using Devise

### User Model Updates
- Added Firebase fields and validations
- Added `from_firebase_uid` class method
- Added `firebase_user?` instance method

### Application Controller
- Updated to support both Devise and Firebase authentication
- Hybrid authentication system

## Frontend Implementation

### Login Page (`/login`)
- Traditional email/password form (Devise)
- Google sign-in button (Firebase)
- Email sign-in button with modal (Firebase)

### Signup Page (`/signup`)
- Traditional registration form (Devise)
- Google sign-up button (Firebase)
- Email sign-up button with modal (Firebase)

### JavaScript Integration
- Firebase Auth SDK integration
- Token handling and API communication
- User feedback and error handling
- Automatic redirects after successful authentication

## API Endpoints

### POST `/firebase/auth`
Authenticates user with Firebase ID token.

**Request:**
```json
{
  "id_token": "firebase-id-token-here"
}
```

**Response (Success):**
```json
{
  "message": "Authenticated successfully",
  "user": { ... },
  "firebase_payload": { ... },
  "firebase_configured": true
}
```

**Response (Error):**
```json
{
  "error": "Firebase not configured",
  "firebase_configured": false
}
```

### POST `/firebase/link`
Links Firebase account to existing authenticated user.

**Request:**
```json
{
  "id_token": "firebase-id-token-here"
}
```

## Authentication Flow

### Google Sign-In Flow
1. User clicks "Google" button
2. Firebase Auth SDK opens Google OAuth popup
3. User authenticates with Google
4. Firebase returns ID token
5. Frontend sends token to `/firebase/auth`
6. Backend verifies token with Google
7. Backend creates/finds user and signs in via Devise
8. User is redirected to home page

### Email Sign-In Flow
1. User clicks "Email" button
2. Modal opens with email/password form
3. User enters credentials
4. Firebase Auth SDK authenticates
5. Same flow as Google sign-in continues

## Security Features

- **Token Verification**: All Firebase tokens are verified with Google's public keys
- **CSRF Protection**: Maintained alongside Firebase authentication
- **Unique Constraints**: Firebase UID uniqueness enforced at database level
- **Provider Tracking**: Authentication method tracked for each user
- **Hybrid Authentication**: Seamless integration with existing Devise system

## Testing

### Test Firebase Authentication
1. Set up Firebase project and get configuration
2. Update Firebase config in login/signup views
3. Set environment variables
4. Start Rails server: `rails server`
5. Visit `/login` or `/signup`
6. Test Google and Email authentication

### Test API Endpoint
```bash
curl -X POST http://localhost:3000/firebase/auth \
  -H "Content-Type: application/json" \
  -d '{"id_token": "test-token"}'
```

## Troubleshooting

### Common Issues

1. **"Firebase not configured" Error**
   - Set `FIREBASE_PROJECT_ID` environment variable
   - Restart Rails server

2. **"Invalid ID token" Error**
   - Ensure Firebase project is set up correctly
   - Check that authentication is enabled in Firebase console
   - Verify Firebase configuration in views

3. **Database Connection Issues**
   - Check database configuration in `config/database.yml`
   - Ensure PostgreSQL is running
   - Verify database credentials

4. **Server Port Conflicts**
   - Use different port: `rails server -p 3002`
   - Kill existing Rails processes: `pkill -f "rails server"`

### Debug Mode
Enable detailed logging by adding to `config/environments/development.rb`:
```ruby
config.log_level = :debug
```

## Migration Details

The migration adds the following to the `users` table:
- `firebase_uid` (string) - Firebase user identifier
- `provider` (string) - Authentication provider
- Unique index on `firebase_uid`
- Unique index on `[:firebase_uid, :provider]`

## User Data Flow

1. **New Firebase User**: Creates new User record with Firebase data
2. **Existing Email User**: Links Firebase account to existing email user
3. **Existing Firebase User**: Signs in existing Firebase user
4. **Data Population**: First name, last name extracted from Firebase or generated

## Support

For issues or questions:
1. Check Firebase console configuration
2. Verify environment variables
3. Review Rails server logs
4. Test with valid Firebase tokens
5. Ensure database migrations are run

## Next Steps

1. Configure Firebase project and get credentials
2. Update Firebase configuration in views
3. Set environment variables
4. Test authentication flows
5. Customize UI as needed
6. Add additional providers if required
