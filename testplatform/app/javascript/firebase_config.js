// Firebase Configuration
// Replace with your Firebase project configuration
const firebaseConfig = {
  apiKey: "your-api-key-here",
  authDomain: "your-project-id.firebaseapp.com",
  projectId: "your-project-id",
  storageBucket: "your-project-id.appspot.com",
  messagingSenderId: "your-sender-id",
  appId: "your-app-id-here"
};

// Initialize Firebase
import { initializeApp } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-app.js";
import { getAuth, signInWithPopup, GoogleAuthProvider, signInWithEmailAndPassword, createUserWithEmailAndPassword, signOut } from "https://www.gstatic.com/firebasejs/10.7.1/firebase-auth.js";

const app = initializeApp(firebaseConfig);
const auth = getAuth(app);

// Firebase Auth Service
class FirebaseAuthService {
  constructor() {
    this.auth = auth;
    this.googleProvider = new GoogleAuthProvider();
  }

  // Sign in with Google
  async signInWithGoogle() {
    try {
      const result = await signInWithPopup(this.auth, this.googleProvider);
      const user = result.user;
      const idToken = await user.getIdToken();
      
      // Send token to Rails backend
      const response = await fetch('/firebase/auth', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': this.getCSRFToken()
        },
        body: JSON.stringify({ id_token: idToken })
      });
      
      const data = await response.json();
      
      if (response.ok) {
        localStorage.setItem('jwt_token', data.token);
        return { success: true, user: data.user, token: data.token };
      } else {
        throw new Error(data.error || 'Authentication failed');
      }
    } catch (error) {
      console.error('Google sign-in error:', error);
      return { success: false, error: error.message };
    }
  }

  // Sign in with email and password
  async signInWithEmail(email, password) {
    try {
      const result = await signInWithEmailAndPassword(this.auth, email, password);
      const user = result.user;
      const idToken = await user.getIdToken();
      
      // Send token to Rails backend
      const response = await fetch('/firebase/auth', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': this.getCSRFToken()
        },
        body: JSON.stringify({ id_token: idToken })
      });
      
      const data = await response.json();
      
      if (response.ok) {
        localStorage.setItem('jwt_token', data.token);
        return { success: true, user: data.user, token: data.token };
      } else {
        throw new Error(data.error || 'Authentication failed');
      }
    } catch (error) {
      console.error('Email sign-in error:', error);
      return { success: false, error: error.message };
    }
  }

  // Sign up with email and password
  async signUpWithEmail(email, password) {
    try {
      const result = await createUserWithEmailAndPassword(this.auth, email, password);
      const user = result.user;
      const idToken = await user.getIdToken();
      
      // Send token to Rails backend
      const response = await fetch('/firebase/auth', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': this.getCSRFToken()
        },
        body: JSON.stringify({ id_token: idToken })
      });
      
      const data = await response.json();
      
      if (response.ok) {
        localStorage.setItem('jwt_token', data.token);
        return { success: true, user: data.user, token: data.token };
      } else {
        throw new Error(data.error || 'Registration failed');
      }
    } catch (error) {
      console.error('Email sign-up error:', error);
      return { success: false, error: error.message };
    }
  }

  // Sign out
  async signOut() {
    try {
      await signOut(this.auth);
      localStorage.removeItem('jwt_token');
      return { success: true };
    } catch (error) {
      console.error('Sign out error:', error);
      return { success: false, error: error.message };
    }
  }

  // Get current authenticated user
  getCurrentUser() {
    return this.auth.currentUser;
  }

  // Get JWT token from localStorage
  getJWTToken() {
    return localStorage.getItem('jwt_token');
  }

  // Check if user is authenticated
  isAuthenticated() {
    return !!this.getJWTToken() && !!this.getCurrentUser();
  }

  // Get CSRF token from meta tag
  getCSRFToken() {
    const meta = document.querySelector('meta[name="csrf-token"]');
    return meta ? meta.getAttribute('content') : '';
  }
}

// Export the service
window.FirebaseAuthService = FirebaseAuthService;
window.firebaseAuthService = new FirebaseAuthService();
