#!/bin/bash

# Cloud Run Setup for Rails App
# Make sure you have gcloud CLI installed and configured

echo "Setting up Rails app on Cloud Run..."

# 1. Set your project ID (replace with your actual project ID)
PROJECT_ID="green-471914"
REGION="us-central1"

echo "PROJECT_ID=$PROJECT_ID"
echo "REGION=$REGION"

# 2. Enable required APIs
echo "Enabling required APIs..."
gcloud services enable run.googleapis.com cloudbuild.googleapis.com sql-component.googleapis.com sqladmin.googleapis.com

# 3. Create Cloud SQL PostgreSQL instance
echo "Creating Cloud SQL PostgreSQL instance..."
gcloud sql instances create rails-db \
    --database-version=POSTGRES_14 \
    --tier=db-f1-micro \
    --region=$REGION \
    --storage-size=10GB \
   
# 4. Create database and user
echo "Creating database and user..."
gcloud sql databases create rails_production --instance=rails-db
gcloud sql users create railsuser --instance=rails-db --password=your_secure_password

# 5. Get database connection details
echo "Getting database connection details..."
DB_HOST=$(gcloud sql instances describe rails-db --format="value(ipAddresses.ipAddress)")
echo "Database Host: $DB_HOST"

# 6. Build and deploy container to Cloud Run
echo "Building and deploying container..."
gcloud builds submit --tag gcr.io/$PROJECT_ID/rails-app .

# 7. Deploy to Cloud Run with environment variables
echo "Deploying to Cloud Run..."
gcloud run deploy rails-app \
    --image gcr.io/$PROJECT_ID/rails-app \
    --platform managed \
    --region=$REGION \
    --allow-unauthenticated \
    --set-env-vars="RAILS_ENV=production" \
    --set-env-vars="DATABASE_URL=postgresql://railsuser:your_secure_password@$DB_HOST:5432/rails_production" \
    --set-env-vars="SECRET_KEY_BASE=$(openssl rand -hex 32)" \
    --set-env-vars="FIREBASE_PROJECT_ID=your-firebase-project-id"

# 8. Get the service URL
SERVICE_URL=$(gcloud run services describe rails-app --region=$REGION --format="value(status.url)")
echo "Your app is deployed at: $SERVICE_URL"

# 9. Configure Firebase (if using)
echo "Don't forget to:"
echo "1. Add $SERVICE_URL to your Firebase authorized domains"
echo "2. Update your Firebase project configuration"
echo "3. Set up database migrations: gcloud run jobs execute migrate --region=$REGION"
