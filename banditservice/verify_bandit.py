import requests
import json

url = "http://localhost:8000/recommend"
context = [0.5, 0.5, 0.2, 0.5, 0.0, 0.3] # dummy context

# 1. Request without target_domain
payload_base = {
    "user_id": 1,
    "context": context,
    "top_k": 5
}
print("--- Request 1: No Target Domain ---")
try:
    resp1 = requests.post(url, json=payload_base).json()
    for item in resp1['recommendations']:
        print(f"Course {item['course_id']} ({item.get('domain')}): {item['score']}")
except Exception as e:
    print(f"Error: {e}")

# 2. Request WITH target_domain = 'Web Development' (Course 1 has this category)
payload_boost = {
    "user_id": 1,
    "context": context,
    "top_k": 5,
    "target_domain": "Web Development" # Matches course 1 category
}
print("\n--- Request 2: Target Domain = 'Web Development' ---")
try:
    resp2 = requests.post(url, json=payload_boost).json()
    for item in resp2['recommendations']:
        print(f"Course {item['course_id']} ({item.get('domain')}): {item['score']}")
except Exception as e:
    print(f"Error: {e}")
