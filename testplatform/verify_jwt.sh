#!/bin/bash

# 1. Sign Up
echo "--- 1. Signing Up ---"
EMAIL="jwt_test_$(date +%s)@example.com"
echo "Using email: $EMAIL"
curl -s -X POST http://localhost:3001/users \
  -H "Content-Type: application/json" \
  -d "{
    \"user\": {
      \"email\": \"$EMAIL\",
      \"password\": \"password123\",
      \"password_confirmation\": \"password123\"
    }
  }" > signup_response.json
echo "Signup Response:"
cat signup_response.json
echo ""

# 2. Log In
echo -e "\n--- 2. Logging In ---"
# We need to capture the Authorization header
curl -s -i -X POST http://localhost:3001/users/sign_in \
  -H "Content-Type: application/json" \
  -d "{
    \"user\": {
      \"email\": \"$EMAIL\",
      \"password\": \"password123\"
    }
  }" > login_response.txt

# Extract Token (get everything after "Authorization: ")
TOKEN=$(grep -i "^authorization:" login_response.txt | head -n 1 | sed 's/^authorization: //i' | tr -d '\r')
echo "Extracted Token: $TOKEN"

if [ -z "$TOKEN" ]; then
    echo "❌ Login Failed - No Token Received"
    cat login_response.txt
    exit 1
fi

# 3. Access Protected Route (Create Attempt)
echo -e "\n--- 3. Creating Attempt with Token ---"
# We'll use a dummy test_id=1, answers={}
# This expects HTML or JSON response depending on controller.
# We'll send JSON content type, but controller renders result.html.erb.
# For API test, we just check if we get 200 OK (access granted) vs 401.

# Note: AttemptsController renders a view. If we request JSON, it might error if view is HTML.
# But auth should pass.
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X POST http://localhost:3001/attempts \
  -H "Authorization: $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "test_id": 1,
    "answers": {"1": "a"}
  }')

echo "Attempts Request HTTP Code: $HTTP_CODE"

if [ "$HTTP_CODE" == "200" ]; then
    echo "✅ Success! Accessed protected route with JWT."
else
    echo "❌ Failed! HTTP Code: $HTTP_CODE"
    curl -s -X POST http://localhost:3001/attempts \
      -H "Authorization: $TOKEN" \
      -H "Content-Type: application/json" \
      -d '{"test_id": 1}'
fi
